<template>
    <MainBanner />
    <form class="form-container" @submit.prevent="handleLogin">
        <h1>Login</h1>
        <div class="login-content">
            <div class="form-row">
                <input type="text" name="username" id="username" v-model="form.username"
                    :class="{ empty: form.username === '', filled: form.username !== '' }">
                <label for="username">Username </label>
            </div>
            <div class="form-row">
                <input type="password" name="password" id="password" v-model="form.password"
                    :class="{ empty: form.password === '', filled: form.password !== '' }">
                <label for="password">Password </label>
                <div v-if="showError" class="error-message">
                    <p>⚠️ Username or password incorrect</p>
                </div>
            </div>
        </div>
        <input type="submit" value="Login" :disabled="isSubmitting">
        <p id="register">Don't have an account? <span id="register_button" @click="goRegister">Register</span>
        </p>
    </form>
</template>

<script>
import MainBanner from '@/components/MainBanner.vue';

export default {
    name: 'LoginPage',
    components: {
        MainBanner
    },
    data() {
        return {
            form: {
                username: '',
                password: '',
            },
            isSubmitting: false,
            showError: false,
        }
    },
    methods: {
        async handleLogin() {
            this.isSubmitting = true;
            this.showError = false;

            const backend = process.env.VUE_APP_BACKEND;

            try {
                const response = await fetch(backend + "login", {
                    method: "POST",
                    headers: {
                        "content-type": "application/json",
                    },
                    body: JSON.stringify(this.form)
                });
                const json = await response.json();
                if (response.ok) {
                    localStorage.setItem("auth-token", json.token)
                    localStorage.setItem("user_id", json.user_id)
                    localStorage.setItem("username", this.form.username)
                    this.$router.push("Account")
                } else {
                    this.showError = true;
                    console.log(json)
                }

            } catch (error) {
                console.error('Error during login:', error);
            } finally {
                this.isSubmitting = false;
            }

        },
        goRegister() {
            this.$router.push("/register");
        }
    }
}
</script>

<style scoped>
.form-container {
    color: var(--tertiary-color);
    background-color: var(--secondary-color);

    padding: 30px;
    border-radius: 15px;
    width: 300px;
    margin: auto;
}

h1 {
    margin-top: 0;
    margin-bottom: 32px;
}

input[type="text"],
input[type="password"] {
    padding: 5px 5px;
    width: 100%;
    box-sizing: border-box;
    background: none;
    border: none;
    border-bottom: 1px solid var(--tertiary-color);
    color: var(--tertiary-color);
    outline: none;
}

.form-row {
    display: flex;
    flex-direction: column;
}

label {
    padding-left: 5px;
    position: absolute;
    transition: transform 0.5s;
    cursor: text;
}

.login-content {
    display: flex;
    flex-direction: column;
    gap: 50px;
    margin-bottom: 30px;
}

input[type="text"]:focus+label,
input[type="password"]:focus+label,
input.filled+label {
    transform: translateY(-100%);
}

input[type="submit"] {
    background-color: var(--tertiary-color);
    color: var(--primary-color);
    padding: 10px;
    border-radius: 10px;
    border: none;
    cursor: pointer;
    width: 100%;
    box-sizing: border-box;
    font-weight: 500;
    margin-top: 15px;
    margin-bottom: 20px;
}


input[type="submit"]:hover {
    filter: brightness(70%);
}

#register {
    text-align: center;
    margin: 0px;
    font-size: small;
}

#register_button {
    font-weight: bold;
    cursor: pointer;
}

#register_button:hover {
    text-decoration-line: underline;
}

.error-message {
    margin-top: 10px;
    font-size: small;
    text-align: left;
    font-weight: bold;
}

p {
    margin: 0%;
}
</style>