<template>
    <div class="game-container">
        <div class="gameBar">
            <p id="time-spend">
                {{ formattedTime }}
            </p>
            <p id="Mine-left">
                Mine left: {{ mine_left }}
            </p>
            <el-button class="button" link @click="restartGame()"><span id="restart">restart</span></el-button>
        </div>
        <GameGrid ref="GameGridRef" :size="size" :initialMineCount="initialMineCount" :mine_left="mine_left"
            @start-timer="startTimer" @mine-plus="increseadMineLeft" @mine-minus="decreseadMineLeft" @victory="victory"
            @game-over="gameOver" />
    </div>

    <el-dialog v-model="dialogVictoryVisible" title="Congratulation!" width="500">
        <span>You won in {{ formattedTime }}</span>
        <template #footer>
            <div class="dialog-footer">
                <el-button @click="dialogVictoryVisible = false" class="close-button">close</el-button>
                <el-button type="primary" @click="dialogVictoryVisible = false; restartGame()" class="restart-button">
                    restart
                </el-button>
            </div>
        </template>
    </el-dialog>

    <el-dialog v-model="dialogLooseVisible" title="Game Over" width="500">
        <span>You lost. Do you want to try again?</span>
        <template #footer>
            <div class="dialog-footer">
                <el-button @click="dialogLooseVisible = false" class="close-button">close</el-button>
                <el-button type="primary" @click="dialogLooseVisible = false; restartGame()" class="restart-button">
                    try again
                </el-button>
            </div>

        </template>
    </el-dialog>
</template>

<script>
import GameGrid from './GameGrid.vue';
import { useSettingsStore } from '@/stores/settingsStore';


export default {
    name: 'gameContainer',
    components: {
        GameGrid,
    },

    setup() {
        const settings = useSettingsStore();
        return {
            initialMineCount: settings.mine,
            difficulty: settings.difficulty,
        }
    },
    data() {

        return {
            timer: 0,
            start: null,
            mine_left: this.initialMineCount,
            rightClick: false,

            size: 10,
            dialogVictoryVisible: false,
            dialogLooseVisible: false,
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
            this.mine_left = this.initialMineCount;
            this.$refs.GameGridRef.CreateGrid();
            this.$refs.GameGridRef.start = false;
            this.$refs.GameGridRef.finish = false;
            this.$refs.GameGridRef.mine_loc = [];
        },

        increseadMineLeft() {
            this.mine_left++;
        },

        decreseadMineLeft() {
            this.mine_left--;
        },

        gameOver() {
            this.stopTimer()
            this.dialogLooseVisible = true;
        },

        victory() {
            this.stopTimer()
            const token = localStorage.getItem("auth-token")
            if (token) {
                this.postNewRecord(token)
            }
            this.dialogVictoryVisible = true;
        },
        async postNewRecord(token) {
            const backend = process.env.VUE_APP_BACKEND;
            const user = localStorage.getItem("user_id");

            const body = {
                "record": {
                    "score": this.timer,
                    "difficulty": this.difficulty
                }
            }
            try {

                const response = await fetch(backend + "users/" + user + "/record", {
                    method: "POST",
                    headers: {
                        'Content-Type': 'application/json',
                        "authorization": `Bearer ${token}`
                    },
                    body: JSON.stringify(body),

                });
                console.log(await response.json());
            } catch (e) {
                console.error("network error :", e);
            }
        },
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
    /* border: 1px solid; */
    border-radius: 15px;
    background-color: var(--primary-color);
}

.gameBar {
    display: flex;
    justify-content: space-between;
    align-items: center;

    color: var(--tertiary-color);
    /* border: 1px solid; */
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    background-color: var(--secondary-color);
    padding: 10px;
}


.game {
    border: 1px solid;
    margin-top: 0px;
}

#Mine-left {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}

#time-spend {
    margin-top: 5px;
    margin-bottom: 5px;
}

.flag {
    width: 40px;
    height: 40px;
}

.button {
    color: var(--tertiary-color)
}

#restart {
    color: var(--tertiary-color)
}

.close-button {
    color: var(--tertiary-color);
    background-color: var(--secondary-color);
    border: none;
}

.close-button:hover {
    filter: brightness(150%);
    color: var(--tertiary-color);
    background-color: var(--secondary-color);
}

.restart-button {
    color: var(--secondary-color);
    background-color: var(--tertiary-color);
    border: none;
}

.restart-button:hover {
    filter: brightness(74%);
    color: var(--secondary-color);
    background-color: var(--tertiary-color);
}
</style>