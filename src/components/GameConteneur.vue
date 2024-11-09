<template>
    <div class="game-container">
        <div class="gameBar">
            <p>
                time
            </p>
            <p id="Mine-left">
                Mine left
            </p>
            <p>
                restart
            </p>
        </div>
        <p class='game'>
            game
        </p>
    </div>


</template>

<script>

export default {
    name: 'gameContainer'
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

#Mine-left {
    color: aqua;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}

.game {
    color: purple;
    border: 1px solid;
}
</style>