<template>
    <div class="user-information">
        <div class="user-name">
            <h1>Username</h1>
        </div>
        <div class="user-data">
            <div class="user-picture-container">
                <div class="user-picture">
                    <img class="mine" alt="this is a mine" src="../assets/mine.webp">
                </div>
                <input type="file" id="fileInput" @change="onFileSelected" accept="image/*" hidden />
                <button class="image-loader" @click="loadPicture">Upload picture</button>
            </div>
            <div class="user-records">
                <div class="difficulty-selector">
                    <button class="boutton-select-dif" id="left" @click="selectorDown">&lt;</button>
                    <p id="difficulty"> {{ difficulty_selector[current_difficulty_index] }}</p>
                    <button class="boutton-select-dif" id="right" @click="selectorUp">&gt;</button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Index</th>
                            <th>Score</th>
                            <th>Date</th>
                            <th>Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(record, index) in records[difficulty_selector[current_difficulty_index]]"
                            :key="record.value">
                            <th>{{ index + 1 }}</th>
                            <td>{{ record.score }}</td>
                            <td>{{ record.date }}</td>
                            <td>{{ record.hour }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</template>

<script>

export default {
    name: "UserView",
    data() {
        return {
            current_difficulty_index: 0,
            difficulty_selector: ['easy', 'medium', 'hard'],
            records: {
                easy: [
                    { 'score': '44:39', 'date': '2024-08-15', 'hour': '10:43' },
                    { 'score': '26:41', 'date': '2024-07-25', 'hour': '05:41' },
                    { 'score': '35:21', 'date': '2024-01-19', 'hour': '04:04' },
                    { 'score': '47:25', 'date': '2024-12-19', 'hour': '11:23' },
                    { 'score': '58:40', 'date': '2024-04-29', 'hour': '07:28' },
                    { 'score': '51:37', 'date': '2024-03-09', 'hour': '20:21' },
                    { 'score': '46:28', 'date': '2024-04-16', 'hour': '08:25' },
                    { 'score': '38:44', 'date': '2024-12-25', 'hour': '05:10' },
                    { 'score': '11:01', 'date': '2024-06-03', 'hour': '02:34' },
                    { 'score': '51:39', 'date': '2024-08-04', 'hour': '17:28' }
                ],
                medium: [
                    { 'score': '58:40', 'date': '2024-04-29', 'hour': '07:28' },
                ]
            },
            picture: "",
        }
    },
    methods: {
        selectorDown() {
            this.current_difficulty_index = ((this.current_difficulty_index - 1) + 3) % 3;
        },
        selectorUp() {
            this.current_difficulty_index = (this.current_difficulty_index + 1) % 3;
        },
        loadPicture() {
            document.getElementById("fileInput").click()
        },
        onFileSelected(event) {
            const file = event.target.files;
            if (file.length > 0) {
                if (file[0].type.startsWith("image/")) {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        this.picture = e.target.result;
                        console.log(this.picture)
                    }
                    reader.readAsDataURL(file[0])
                }
            }
        }
    }
}

</script>

<style scoped>
.user-information {
    background-color: var(--secondary-color);
    border-radius: 10px;
    padding-bottom: 40px;
    padding-top: 10px;
}

h1 {
    color: var(--tertiary-color);
}

.user-data {
    display: flex;
    justify-content: center;
    gap: 50vh;
}

.user-picture {
    overflow: hidden;
    height: 200px;
    width: 200px;
    border-radius: 50%;
}

table {
    border-collapse: collapse;
    border-radius: 15px;
    overflow: hidden;
}

th,
td {
    padding: 10px;
    color: var(--tertiary-color);
    background-color: var(--secondary-color-alt);
}

th {
    background-color: var(--primary-color);
}

.mine {
    height: 100%;
    width: 100%;
}

.difficulty-selector {
    display: flex;
    justify-content: space-around;
    align-items: center;
    background-color: var(--secondary-color-alt);
    border-radius: 15px;
    margin-left: 10%;
    margin-right: 10%;
}

.boutton-select-dif {
    background: none;
    border: 0;
    color: var(--tertiary-color);
    padding: 0 10px;
    margin: 10px 0;
    cursor: pointer;
    font-size: larger;
}

#left {
    padding-right: 25px;
    border-right: 1px solid var(--tertiary-color)
}

#right {
    padding-left: 25px;
    border-left: 1px solid var(--tertiary-color)
}

.user-picture img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.image-loader {
    background-color: var(--secondary-color-alt);
    border: 0;
    border-radius: 12px;
    padding: 10px;
    color: var(--tertiary-color);
    margin-top: 13px;
    cursor: pointer;
}

#difficulty {
    color: var(--tertiary-color);
    margin: 0;
}
</style>