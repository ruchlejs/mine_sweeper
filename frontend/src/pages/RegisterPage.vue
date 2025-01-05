<template>
    <MainBanner />
    <form class="form-container" @submit.prevent="handleRegister">
        <h1>Register</h1>
        <div class="login-content">
            <div class="form-row">
                <input type="text" name="username" id="username" v-model="form.username"
                    :class="{ empty: form.username === '', filled: form.username !== '' }">
                <label for="username">Username </label>
                <div v-if="userAlreadyExist" class="user-already-exist">
                    <p>⚠️ This username is already taken</p>
                </div>
            </div>
            <div class="form-row">
                <input type="password" name="password" id="password" v-model="form.password"
                    :class="{ empty: form.password === '', filled: form.password !== '' }">
                <label for="password">Password </label>
            </div>
            <div class="form-row">
                <input type="password" name="verify-password" id="verify-password" v-model="verify_password"
                    :class="{ empty: verify_password === '', filled: verify_password !== '' }" @input="verifyPassword">
                <label for="verify-password">Verify password </label>
                <div v-if="showError" class="different-password">
                    <p>⚠️ The passwords are not the same!</p>
                </div>
            </div>
        </div>
        <input type="submit" value="Register" :disabled="isSubmitting || misMatch">
    </form>
</template>

<script>
import MainBanner from '@/components/MainBanner.vue';

export default {
    name: 'RegisterPage',
    components: {
        MainBanner
    },
    data() {
        return {
            form: {
                username: '',
                password: '',
            },
            verify_password: '',
            isSubmitting: false,
            misMatch: false,
            showError: false,
            userAlreadyExist: false,
        }
    },
    watch: {
        'form.password': 'checkPassword',
        verify_password: 'checkPassword',
        'form.username'() {
            if (this.userAlreadyExist)
                this.userAlreadyExist = false;
        }
    },
    methods: {
        async handleRegister() {
            this.isSubmitting = true;

            const backend = process.env.VUE_APP_BACKEND;
            const body = {
                user: this.form,
            }

            try {
                const response = await fetch(backend + "users", {
                    method: "POST",
                    headers: {
                        "content-type": "application/json",
                    },
                    body: JSON.stringify(body),
                });
                const json = await response.json();
                if (response.ok) {
                    localStorage.setItem("auth-token", json.token)
                    localStorage.setItem("user_id", json.user.id)
                    localStorage.setItem("username", this.form.username)
                    this.$router.push("Account")
                } else {
                    console.log(json.errors)
                    if (json.errors.username) {
                        this.userAlreadyExist = true;
                    }
                }

            } catch (error) {
                console.error('Error during login:', error);
            } finally {
                this.isSubmitting = false;
            }
        },
        checkPassword() {
            this.misMatch = this.form.password !== this.verify_password;
            if (this.verify_password && this.misMatch) {
                this.showError = true;
            } else {
                this.showError = false;
            }
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

.different-password,
.user-already-exist {
    margin-top: 10px;
    font-size: small;
    text-align: left;
    font-weight: bold;
}

p {
    margin: 0%;
}

input[type="submit"]:hover:disabled {
    filter: none;
    cursor: not-allowed;
}
</style>