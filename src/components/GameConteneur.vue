<template>
    <div class="game-container">
        <div class="gameBar">
            <p id="time-spend">
                {{ formattedTime }}
            </p>
            <p id="Mine-left">
                Mine left: {{ mine_left }}
            </p>
            <p id="restart-button">
                restart
            </p>
        </div>
        <GameGrid :size="size" />
    </div>

    <button @click="console.log(size)">
        bouton test
    </button>

    <button @click="startTimer()">
        lancer timer
    </button>

    <button @click="stopTimer()">
        stop timer
    </button>

    <label for="chosenSize">Choose a size: </label>
    <select id="chosenSize" v-model="size">
        <option v-for="gridSize in possible_size" :key="gridSize" :value="gridSize">
            {{ gridSize }}x{{ gridSize }}
        </option>
    </select>

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
            mine_left: 0,

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
</style>