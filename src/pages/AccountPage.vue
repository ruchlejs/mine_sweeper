<template>
    <MainBanner />
    <!-- <LoginWindow /> -->
    <UserView />
</template>

<script>
import MainBanner from '@/components/MainBanner.vue';
import UserView from '@/components/UserView.vue';
// import LoginWindow from '@/components/LoginWindow.vue';

export default {
    name: 'AccountPage',
    components: {
        MainBanner,
        // LoginWindow,
        UserView
    },
}
</script>