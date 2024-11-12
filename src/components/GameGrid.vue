<template>
    <div class="game-grid" :style="{ gridTemplateColumns: `repeat(${size}, 1fr)` }">
        <div v-for="(row, rowIndex) in grid" :key="rowIndex" class="grid-row">
            <div v-for="(col, colIndex) in row" :key="colIndex" class="grid-col"
                @click="cellReveal(rowIndex, colIndex)">
                {{ cellContent(rowIndex, colIndex) }}
            </div>
        </div>

        <p @click="PlaceMines(); compute_adjacent_mine()">
            place mines
        </p>

        <P>
            reveal mine next cells
        </P>
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
            grid: []
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
                }))
            );
        },

        cellReveal(row, col) {
            const cell = this.grid[row][col];
            if (!cell.revealed) {
                cell.revealed = true;
            }
        },

        PlaceMines() {
            let mine_to_place = this.mine_left;
            const gridArea = this.size * this.size;
            const mineProbability = this.mine_left / gridArea;

            while (mine_to_place > 0) {
                this.grid.forEach((row) => {
                    row.forEach((cell) => {
                        if (!mine_to_place) return;

                        let random = Math.random() < mineProbability;
                        if (random) {
                            if (!cell.mine) {
                                mine_to_place--;
                                cell.mine = true;
                                cell.revealed = true;
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

                                this.grid[newRow][newCol].revealed = true
                            }
                        });
                    }
                })
            })
        },

        cellContent(row, col) {
            const cell = this.grid[row][col]
            if (cell.revealed && cell.mine) return "mine";
            if (cell.revealed && !cell.mine) return cell.adjacent_mine;
            return `${row}x${col}`

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