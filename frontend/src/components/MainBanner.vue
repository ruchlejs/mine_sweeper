<template>
    <div id="Banner">
        <el-button link><router-link to="./" class="link">MineSweeper</router-link></el-button>

        <el-button id="account" link><router-link to="./account" class="link">Account</router-link></el-button>

        <el-button link><router-link to="./settings" class="link">Settings</router-link></el-button>
    </div>
</template>

<script>

export default {
    name: 'MainBanner'
}

</script>

<style scoped>
#Banner {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    margin-bottom: 50px;
    border-radius: 13px;

    /* border: 1px solid; */
    background-color: var(--secondary-color);
}

#account {
    position: absolute;
    left: 50%;
    transform: translateX(-75%);
}

.link {
    text-decoration: none;

    color: var(--tertiary-color);
}
</style>
