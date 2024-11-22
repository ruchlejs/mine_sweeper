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
  --primary-color: #1b1b1b;
  --secondary-color: #333333;
  --tertiary-color: #e74c3c;
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
  margin-left: 7%;
  margin-right: 7%;
  background-color: var(--primary-color);
}
</style>