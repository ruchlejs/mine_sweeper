<template>
    <BandeauComponent />
</template>

<script>
import BandeauComponent from './components/BandeauComponent.vue'

export default {
    name: 'MainComponent',
    components: {
        BandeauComponent
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