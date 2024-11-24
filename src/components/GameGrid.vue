<template>
    <div class="game-grid" :style="{ gridTemplateColumns: `repeat(${size}, 1fr)` }">
        <div v-for="(row, rowIndex) in grid" :key="rowIndex" class="grid-row">
            <div v-for="(col, colIndex) in row" :key="colIndex" class="grid-col"
                :class="classIfReveal(rowIndex, colIndex)" :style="{ fontSize: dynamicFontSize }"
                @click="cellReveal(rowIndex, colIndex)" @contextmenu="putFlag(rowIndex, colIndex)">
                <FlagImage v-if="cellContent(rowIndex, colIndex) === 'flag'"
                    :style="{ height: '100%', width: '100%' }" />
                <MineImage v-else-if="cellContent(rowIndex, colIndex) === 'mine'"
                    :style="{ height: '100%', width: '100%' }" />
                <div v-else>
                    {{ cellContent(rowIndex, colIndex) }}
                </div>



            </div>
        </div>
    </div>
    <div>
    </div>
</template>

<script>
import { useSettingsStore } from '@/stores/settingsStore';
import FlagImage from './FlagImage.vue';
import MineImage from './MineImage.vue';

export default {
    name: 'GameGrid',
    components: {
        FlagImage,
        MineImage,
    },
    props: {
        // size: Number,
        initialMineCount: Number,
        mine_left: Number,
    },

    setup() {
        const sizeStore = useSettingsStore();

        return { size: sizeStore.size }
    },
    data() {
        return {
            grid: [],
            start: false,
            mine_loc: [],
        }
    },

    created() {
        this.CreateGrid();
    },

    watch: {
        size() {
            this.CreateGrid()
        },

        mine_left() {
            if (this.mine_left == 0) {
                this.victoryVerification()
            }
        }
    },

    methods: {
        CreateGrid() {
            this.grid = Array.from({ length: this.size }, () =>
                Array.from({ length: this.size }, () =>
                ({
                    revealed: false,
                    mine: false,
                    adjacent_mine: 0,
                    flag: false,
                }))
            );
        },

        cellReveal(row, col) {
            if (!this.start) {
                this.PlaceMines(row, col);
                this.compute_adjacent_mine();
                this.$emit("start-timer")
                this.start = true;
            }
            const cell = this.grid[row][col];
            if (cell.flag) return;
            if (!cell.revealed) {
                if (!cell.mine) {
                    this.propagation_reveal(row, col)
                }
                else {
                    cell.revealed = true;
                    this.$emit("game-over")
                    console.log("game over")
                }
            }
        },


        PlaceMines(started_row, started_col) {
            let mine_to_place = this.mine_left;
            const gridArea = this.size * this.size;
            const mineProbability = this.mine_left / gridArea;
            this.mine_loc.fl

            const directions = [
                [-1, -1], [-1, 0], [-1, 1],
                [0, -1], [0, 1],
                [1, -1], [1, 0], [1, 1]
            ];

            function isAdjacentToStart(rowIndex, colIndex) {
                for (const [dx, dy] of directions) {
                    if (rowIndex === started_row + dx && colIndex === started_col + dy) {
                        return true;
                    }
                }
                return false;
            }

            while (mine_to_place > 0) {
                this.grid.forEach((row, rowIndex) => {
                    row.forEach((cell, colIndex) => {
                        if (!mine_to_place) return;

                        let random = Math.random() < mineProbability;
                        if (random && started_row != rowIndex && started_col != colIndex && !isAdjacentToStart(rowIndex, colIndex)) {
                            if (!cell.mine) {
                                mine_to_place--;
                                cell.mine = true;

                                this.mine_loc.push([rowIndex, colIndex])
                            }
                        }
                    })
                })
            }
        },

        compute_adjacent_mine() {

            const directions = [
                [-1, -1], [-1, 0], [-1, 1],
                [0, -1], [0, 1],
                [1, -1], [1, 0], [1, 1]
            ];
            this.grid.forEach((row, rowIndex) => {
                row.forEach((cell, cellIndex) => {
                    if (cell.mine) {
                        directions.forEach(([dRow, dCol]) => {
                            const newRow = rowIndex + dRow;
                            const newCol = cellIndex + dCol;

                            if (newRow >= 0 && newRow < this.size && newCol >= 0 && newCol < this.size) {
                                this.grid[newRow][newCol].adjacent_mine++;
                            }
                        });
                    }
                })
            })
        },

        cellContent(row, col) {
            const cell = this.grid[row][col]
            if (!cell.revealed && cell.flag && this.start) return 'flag';
            if (cell.revealed && cell.mine) return "mine";
            if (cell.revealed && !cell.mine) return cell.adjacent_mine;
            return
        },

        propagation_reveal(row, col) {
            const cell = this.grid[row][col];
            cell.revealed = true;
            if (cell.adjacent_mine === 0) {

                const directions = [
                    [-1, 0],
                    [0, -1], [0, 1],
                    [1, 0]
                ];

                directions.forEach(([dRow, dCol]) => {
                    const newRow = row + dRow;
                    const newCol = col + dCol;

                    if (newRow >= 0 && newRow < this.size && newCol >= 0 && newCol < this.size) {
                        const newCell = this.grid[newRow][newCol];
                        if (!newCell.revealed) {
                            if (newCell.adjacent_mine === 0) {
                                this.propagation_reveal(newRow, newCol);
                            }
                            else {
                                newCell.revealed = true;
                            }
                        }
                    }
                });
            }
        },

        putFlag(row, col) {
            event.preventDefault(event);
            const cell = this.grid[row][col];
            if (this.start) {
                if (!cell.revealed) {
                    if (cell.flag) {
                        cell.flag = false;
                        this.$emit("mine-plus")
                    }
                    else {
                        this.$emit("mine-minus")
                        cell.flag = true;
                    }
                }

            }
        },

        victoryVerification() {
            let number_of_mine = this.initialMineCount
            this.mine_loc.forEach(([row, col]) => {
                if (this.grid[row][col].flag) {
                    number_of_mine--;
                }
            })

            if (!number_of_mine) {
                console.log("victory")
                console.log(this.mine_loc)
                this.$emit("victory")
            }
            else {
                console.log("some flag are missplaced")
            }
        },

        classIfReveal(row, col) {
            return { 'revealed': this.grid[row][col].revealed }
        }

    },
    computed: {
        dynamicFontSize() {
            const baseFontSize = 1.7;
            const scaleFactor = 50;
            return `${baseFontSize - this.size / scaleFactor}rem`;
        }
    }

}
</script>

<style scoped>
.game-grid {
    display: grid;

    border-radius: 15px;
    overflow: hidden;
}

.grid-col {
    aspect-ratio: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;

    border-radius: 15px;
    background-color: var(--tertiary-color)
}

.revealed {
    color: var(--tertiary-color);
    border: 1px dashed var(--tertiary-color);
    background-color: var(--primary-color);
}
</style>