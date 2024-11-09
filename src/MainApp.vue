<template>
    <MainBanner />
    <GameConteneur />
</template>

<script>
import MainBanner from './components/MainBanner.vue'
import GameConteneur from './components/GameConteneur.vue';

export default {
    name: 'MainComponent',
    components: {
        MainBanner,
        GameConteneur
    }
}

</script>

<style>
#app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
}
</style>