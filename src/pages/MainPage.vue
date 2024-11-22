<template>
    <MainBanner />
    <GameConteneur />
    <GameGrid />
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