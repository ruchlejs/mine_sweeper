<template>
    <button>
        <router-link to="./">Back to game</router-link>
    </button>
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
export default {
    name: 'SettingsPage',
    data() {
        return {
            themes: [
                { name: 'RGB', colors: ['#ff0000', '#00ff00', '#0000ff'] },
                { name: 'light', colors: ['#ffffff', '#3498db', '#000000'] },
                { name: 'dark', colors: ['#2c3e50', '#34495e', '#ecf0f1'] },
                { name: 'purple', colors: ['#9b59b6', '#8e44ad', '#ffffff'] },
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
    margin-left: 10px;
    border: 1px solid red;
    border-radius: 10px;
    margin: 5px;
    padding: 5px;
}

.theme-picker {
    display: flex;
    flex-direction: column;
    /* border: 1px solid black; */
    /* border-radius: 10px; */
    text-align: left;
    /* align-items: center; */
    width: 100%;
}

.theme-name {
    width: 60px;
    margin-right: 10px;
}

.color-circle {
    border: 1px solid black;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    margin: 10px;
}
</style>