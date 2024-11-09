<template>
    <div id="Banner">
        <p id="title">
            MineSweeper
        </p>
        <p id="account">
            account
        </p>
        <p id="settings">
            settings
        </p>
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
    color: red;
    border: 1px solid;

    margin-bottom: 50px;
}

#title {
    margin-left: 10px;
}

#account {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}

#settings {
    margin-right: 10px;
}
</style>