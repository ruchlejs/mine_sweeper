<template>
    <div id="main">

        <MainBanner />
        <GameConteneur />
        <GameGrid />
    </div>
</template>

<script>
import MainBanner from '../components/MainBanner.vue'
import GameConteneur from '../components/GameConteneur.vue';


export default {
    name: 'MainPage',
    components: {
        MainBanner,
        GameConteneur,
    }
}
</script>

<style scoped></style>