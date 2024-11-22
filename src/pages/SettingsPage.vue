<template>
    <MainBanner />
    <div class="theme-preview">
        the actual theme is :
        <div class="color-circle" :style="{ backgroundColor: 'var(--primary-color)' }"></div>
        <div class="color-circle" :style="{ backgroundColor: 'var(--secondary-color)' }"></div>
        <div class="color-circle" :style="{ backgroundColor: 'var(--tertiary-color)' }"></div>

    </div>

    <div class="theme-picker">
        <div v-for="theme in themes" :key="theme.name" class="theme-preview" @click="setTheme(theme)">
            <p class="theme-name">{{ theme.name }}</p>
            <div v-for="(color, index) in theme.colors" :key="index" :class="['color-circle']"
                :style="{ backgroundColor: color }">
            </div>
        </div>
    </div>
</template>

<script>
import MainBanner from '@/components/MainBanner.vue';

export default {
    name: 'SettingsPage',
    components: {
        MainBanner,
    },

    data() {
        return {
            themes: [
                { name: 'darkred', colors: ['#1b1b1b', '#333333', '#e74c3c'] },
                { name: 'dark-yellow', colors: ['#1b1b1b', '#333333', '#f1c40f'] },
                { name: 'dragon', colors: ['#1b1b1b', '#8b0000', '#ffcc00'] },
                { name: 'lilac', colors: ['#f8f9fa', '#e6e6fa', '#9370db'] },
                { name: 'pink', colors: ['#ffe4e1', '#ffc0cb', '#ff69b4'] },
                { name: 'ninja', colors: ['#1b1b1b', '#2c2c2c', '#5f27cd'] },
                { name: 'hacker', colors: ['#0b0b0b', '#1b1b1b', '#00ff00'] },
            ],
        };
    },

    methods: {
        setTheme(theme) {
            document.documentElement.style.setProperty('--primary-color', theme.colors[0])
            document.documentElement.style.setProperty('--secondary-color', theme.colors[1])
            document.documentElement.style.setProperty('--tertiary-color', theme.colors[2])
        }
    }
};
</script>

<style scoped>
.theme-preview {
    display: flex;
    align-items: center;
    flex-grow: 1;
    flex-basis: 20%;
    justify-content: center;
    margin-left: 10px;
    border-radius: 10px;
    margin: 5px;
    padding: 10px;

    color: var(--tertiary-color);
    background-color: var(--secondary-color);

    transition: transform 0.5s;
}

.theme-preview:hover {
    transform: scale(1.1);
    border: 1px solid var(--tertiary-color)
}

.theme-picker {
    display: flex;
    /* flex-direction: column; */
    flex-wrap: wrap;
    text-align: left;
    width: 100%;
}

.theme-name {
    /* width: 120px; */
    margin-right: 10px;
}

.color-circle {
    /* border: 1px solid black; */
    width: 20px;
    height: 20px;
    border-radius: 50%;
    margin: 10px;
}
</style>