<template>
  <router-view></router-view>
</template>

<script>


export default {
  name: 'MainComponent',
}

</script>

<style>
:root {
  --primary-color: #ff0000;
  --secondary-color: #00ff00;
  --tertiary-color: #ffffff;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

html,
body {
  background-color: var(--primary-color);
}
</style>