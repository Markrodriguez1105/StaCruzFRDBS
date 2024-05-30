<template>
    <div class="w-100">
        <v-card class="mx-auto pa-12 pb-8" elevation="8" max-width="400" rounded="lg">
            <div class="d-flex justify-center align-center">
                <v-img max-width="100" src="/src/assets/images/logo.png"></v-img>
                <h1>FRDBS</h1>
            </div>
            <div class="text-subtitle-1 text-medium-emphasis">Account</div>

            <v-text-field v-model="user" density="compact" placeholder="Username" prepend-inner-icon="mdi-account"
                variant="outlined" :rules="usernameRules"></v-text-field>

            <div class="text-subtitle-1 text-medium-emphasis d-flex align-center justify-space-between">
                Password
            </div>

            <v-text-field v-model="pass" :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'"
                :type="visible ? 'text' : 'password'" density="compact" placeholder="Enter your password"
                prepend-inner-icon="mdi-lock-outline" variant="outlined" @click:append-inner="visible = !visible"
                :rules="passworkRules"></v-text-field>

            <v-btn class="my-5" :color="color" :text="text" size="large" variant="tonal" block :loading="load"
                @click="login()" to="/Data"></v-btn>
        </v-card>
    </div>
</template>
<script>
import axios from 'axios';

export default {
    data: () => ({
        load: false,
        color: 'blue',
        text: 'Log in',
        visible: false,
        user: '',
        pass: '',
        usernameRules: [v => !!v || 'Required'],
        passworkRules: [v => !!v || 'Required'],
    }),
    methods: {
        login() {
            axios.post('http://localhost/StaCruzFRDBS_Php/crud.php', {
                action: 'login',
                user: this.user,
                pass: this.pass,
            }).then(response => {
                if (this.user.length > 0 && this.pass.length > 0) {
                    this.load = true;
                    setTimeout(() => {
                        if (response.data) {
                            this.load = false;
                            this.$emit('access', response.data);
                        } else {
                            this.load = false;
                            this.color = 'red';
                            this.text = 'Incorrect';
                            setTimeout(() => {
                                this.color = 'blue';
                                this.text = 'Log in';
                            }, 2000);
                        }
                    }, 2000);
                }
            })
        }
    },
    mounted() {
        this.login()
    }
}
</script>