<template>
    <div class="game-grid" :style="{ gridTemplateColumns: `repeat(${size}, 1fr)` }">
        <div v-for="(row, rowIndex) in grid" :key="rowIndex" class="grid-row">
            <div v-for="(col, colIndex) in row" :key="colIndex" class="grid-col"
                @click="cellReveal(rowIndex, colIndex)">
                <span v-if="col.revealed"> revelead</span>
                <span v-else>{{ rowIndex }}x{{ colIndex }}</span>
            </div>
        </div>

    </div>
</template>

<script>
export default {
    name: 'GameGrid',
    props: {
        size: Number,
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
                }))
            );
        },

        cellReveal(row, col) {
            const cell = this.grid[row][col];
            if (!cell.revealed) {
                cell.revealed = true;
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