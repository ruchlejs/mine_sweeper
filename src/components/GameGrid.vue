<template>
    <div class="game-grid" :style="{ gridTemplateColumns: `repeat(${size}, 1fr)` }">
        <div v-for="(row, rowIndex) in grid" :key="rowIndex" class="grid-row">
            <div v-for="(col, colIndex) in row" :key="colIndex" class="grid-col" @click="cellReveal(rowIndex, colIndex)"
                @contextmenu="putFlag(rowIndex, colIndex)">
                {{ cellContent(rowIndex, colIndex) }}
            </div>
        </div>

        <p @click="compute_adjacent_mine()">
            compute adjacent mines
        </p>
    </div>
</template>

<script>
export default {
    name: 'GameGrid',
    props: {
        size: Number,
        mine_left: Number,
    },
    data() {
        return {
            grid: [],
            start: false,
        }
    },

    created() {
        this.CreateGrid();
    },

    watch: {
        size() {
            this.CreateGrid()
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
                this.start = true;
            }
            const cell = this.grid[row][col];
            if (cell.flag) return;
            if (!cell.revealed) {
                if (!cell.mine) {
                    this.propagation_reveal(row, col)
                }
                else {
                    // alert("Game over");
                    cell.revealed = true;
                }
            }
        },

        PlaceMines(started_row, started_col) {
            let mine_to_place = this.mine_left;
            const gridArea = this.size * this.size;
            const mineProbability = this.mine_left / gridArea;

            while (mine_to_place > 0) {
                this.grid.forEach((row, rowIndex) => {
                    row.forEach((cell, colIndex) => {
                        if (!mine_to_place) return;

                        let random = Math.random() < mineProbability;
                        if (random && started_row != rowIndex && started_col != colIndex) {
                            if (!cell.mine) {
                                mine_to_place--;
                                cell.mine = true;
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
            return `${row}x${col}`
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
                if (cell.flag) {
                    cell.flag = false;
                }
                else {
                    cell.flag = true;
                }
            }
        }

    }

}
</script>

<style scoped>
.game-grid {
    display: grid;
    /* grid-template-columns: repeat(10, 1fr); */
    /* grid-template-rows: repeat(10, 1fr); */
    /* gap: 2px; */
}

.grid-col {
    /* width: 40px;
    height: 40px; */
    border: 1px solid black;

    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}
</style>