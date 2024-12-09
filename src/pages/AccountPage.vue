<template>
    <MainBanner />
    <LoginWindow />
</template>

<script>
import MainBanner from '@/components/MainBanner.vue';
import LoginWindow from '@/components/LoginWindow.vue';

export default {
    name: 'AccountPage',
    components: {
        MainBanner,
        LoginWindow,
    },
}
</script>