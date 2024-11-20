<template>
    <div class="game-container">
        <div class="gameBar">
            <p id="time-spend">
                {{ formattedTime }}
            </p>
            <p id="Mine-left">
                Mine left: {{ mine_left }}
            </p>
            <button id="restart-button" @click="restartGame()">
                restart
            </button>
        </div>
        <GameGrid ref="GameGridRef" :size="size" :mine_left="mine_left" @start-timer="startTimer"
            @mine-plus="increseadMineLeft" @mine-minus="decreseadMineLeft" />
    </div>


    <label for="chosenSize">Choose a size: </label>
    <select id="chosenSize" v-model="size">
        <option v-for="gridSize in possible_size" :key="gridSize" :value="gridSize">
            {{ gridSize }}x{{ gridSize }}
        </option>
    </select>

    <div class="cell" @contextmenu="handleRightClick">
        <img v-if="rightClick" class="flag" alt="test right click" src="../assets/flag.webp">
    </div>

</template>

<script>
import GameGrid from './GameGrid.vue';


export default {
    name: 'gameContainer',
    components: {
        GameGrid,
    },
    data() {
        return {
            timer: 0,
            start: null,
            mine_left: 10,
            rightClick: false,

            size: 10,
            possible_size: [10, 11]
        }
    },
    methods: {
        startTimer() {
            if (this.start === null) {
                this.start = setInterval(() => {
                    this.timer++;
                }, 1000);
            }
        },

        stopTimer() {
            clearInterval(this.start);
            this.start = null;
        },

        restartTimer() {
            this.stopTimer();
            this.timer = 0;
        },

        beforeDestroy() {
            if (this.start) {
                clearInterval(this.start);
            }
        },

        getFormattedTime() {
            let min = Math.floor(this.timer / 60);
            let sec = this.timer % 60;

            return `${this.pad(min)}:${this.pad(sec)}`;
        },

        pad(number) {
            return number < 10 ? `0${number}` : number;
        },

        handleRightClick() {
            event.preventDefault(event);
            this.rightClick = true;
        },

        restartGame() {
            this.restartTimer();
            this.$refs.GameGridRef.CreateGrid();
            this.$refs.GameGridRef.start = false;
        },

        increseadMineLeft() {
            this.mine_left++;
        },

        decreseadMineLeft() {
            this.mine_left--;
        }
    },

    computed: {
        formattedTime() {
            return this.getFormattedTime();
        }
    }
}
</script>

<style scoped>
.game-container {
    border: 5px solid;
}

.gameBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: blue;
    border: 1px solid;
}


.game {
    color: purple;
    border: 1px solid;
    margin-top: 0px;
}

#Mine-left {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}

#time-spend {
    margin-left: 10px;
}

#restart-button {
    margin-right: 10px;
}

.flag {
    width: 40px;
    height: 40px;
}

.cell {
    width: 40px;
    height: 40px;
    border: 10px solid black;
}
</style>