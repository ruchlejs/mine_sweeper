<template>
    <div id="Banner">
        <p>
            MineSweeper
        </p>
        <p id="account">
            account
        </p>
        <p>
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
}

#account {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}
</style>