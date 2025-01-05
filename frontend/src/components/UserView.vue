<template>
    <div class="user-information">
        <div class="user-name">
            <h1>Username</h1>
        </div>
        <div class="user-data">
            <div class="user-picture-container">
                <div class="user-picture">
                    <img class="mine" alt="this is a mine" :src="picture">
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
                easy: [],
                medium: [],
                hard: []
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
        async onFileSelected(event) {
            const file = event.target.files[0];
            if (!file) return;

            if (file.type.startsWith("image/")) {
                const formData = new FormData();
                formData.append("profile_picture", file)

                const backend = "http://localhost:4000/api/";
                const user = "1/";

                try {
                    const response = await fetch(backend + "users/" + user + "image", {
                        method: "PUT",
                        body: formData
                    });
                    if (response.ok) {
                        console.log("update profile picture with success");
                        this.updateProfilePicture();
                    } else {
                        const error = await response.text();
                        console.log(error)
                        console.error("upload fail:", error);
                    }
                } catch (e) {
                    console.error("network error :", e);
                }
            }
        },
        async fetchRecord() {
            const backend = "http://localhost:4000/api/";
            const user = "1/";
            const response = await fetch(backend + "users/" + user + "record");
            const json = await response.json();

            json.data.sort((a, b) => {
                return a.score - b.score;
            });

            for (let i = 0; i < json.data.length; i++) {
                const date = json.data[i].time;
                const difficulty = json.data[i].difficulty;
                const score = this.convertScore(json.data[i].score);

                const { date: formattedDate, hour: formattedHour } = this.convertDate(date);
                const record = { date: formattedDate, hour: formattedHour, score: `${score}` }

                this.records[difficulty].push(record);
            }

            this.difficulty_selector.forEach(difficulty => {

                this.records[difficulty] = this.records[difficulty].slice(0, 10);
            });
        },
        convertDate(date) {
            const dateObj = new Date(date);

            const year = dateObj.getFullYear();
            const month = dateObj.getMonth() + 1;
            const day = dateObj.getDate();

            const hours = dateObj.getHours();
            const minutes = dateObj.getMinutes();

            return { "date": `${year}-${month}-${day}`, "hour": `${hours}:${minutes}` };
        },
        convertScore(score) {
            let min = score / 60 | 0;
            let sec = score % 60;

            min = min > 9 ? `${min}` : `0${min}`;
            sec = sec > 9 ? `${sec}` : `0${sec}`;

            return `${min}:${sec}`;
        },
        async fetchProfilePicture() {
            const backend = "http://localhost:4000/api/";
            const user = "1/";
            const response = await fetch(backend + "users/" + user + "image");
            const profilePictureURL = response.url;

            return profilePictureURL;
        },
        updateProfilePicture() {
            this.fetchProfilePicture().then(url => {
                this.picture = `${url}?timestamp=${new Date().getTime()}`;
            })
        }
    },
    created() {
        this.updateProfilePicture();
        this.fetchRecord();
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