<template>
    <div class="ma-5">
        <v-row no-gutters class="justify-end ga-2">
            <v-col>
                <v-btn variant="tonal" color="secondary" @click="archiveOn = !archiveOn">{{ buttonArchive }}</v-btn>
            </v-col>
            <v-col cols="2">
                <v-combobox label="Search By" prepend-inner-icon="mdi mdi-filter" flat hide-details single-line
                    variant="solo-filled" density="compact"
                    :items="['DV Number', 'Cheque Number', 'Payee Name', 'Modified By', 'Date Modified']"
                    v-model="filter" clearable></v-combobox>
            </v-col>
            <v-col cols="3">
                <v-text-field prepend-inner-icon="mdi-magnify" v-model="search" density="compact" label="Search"
                    variant="solo-filled" flat hide-details single-line></v-text-field>
            </v-col>
        </v-row>
        <DataTable :document="filteredData" :getDataDb="getDataDb" />
    </div>
</template>
<script>
import axios from 'axios';

export default {
    data() {
        return {
            archiveOn: false,
            filter: '',
            search: '',
            document: [],
        }
    },
    computed: {
        buttonArchive() {
            return this.archiveOn ? 'Back' : 'Archive'
        },
        filteredData() {
            if (this.document) {
                let filteredData = this.document.filter(value => value.archive == this.archiveOn);

                if (this.filter && this.search) {
                    if (this.filter === 'DV Number') {
                        filteredData = filteredData.filter(value => value.dvNo.includes(this.search));
                    } else if (this.filter === 'Cheque Number') {
                        filteredData = filteredData.filter(value => value.chequeNo.includes(this.search));
                    } else if (this.filter === 'Payee Name') {
                        filteredData = filteredData.filter(value => value.payeeName.toLowerCase().includes(this.search.toLowerCase()));
                    } else if (this.filter === 'Modified By') {
                        filteredData = filteredData.filter(value => value.prepBy.toLowerCase().includes(this.search.toLowerCase()));
                    } else if (this.filter === 'Date Modified') {
                        filteredData = filteredData.filter(value => value.prepDate.includes(this.search));
                    }
                }

                return filteredData;
            }
        }
    },
    methods: {
        getDataDb() {
            axios.post('http://localhost/StaCruzFRDBS_Php/crud.php', {
                action: 'fetch',
            }).then((response) => {
                this.document = response.data;
            }).catch(error => {
                console.error("Data Can Retrieve", error);
            })
        }
    },
    mounted() {
        this.getDataDb();
    }
}
</script>