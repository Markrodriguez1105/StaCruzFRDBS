<template>
    <v-table height="100%" fixed-header>
        <thead>
            <tr>
                <th class="text-left">Cheque Date Issued</th>
                <th class="text-left">Cheque No.</th>
                <th class="text-left">Payee</th>
                <th class="text-left">Account Code</th>
                <th class="text-left">Gross Amount</th>
                <th class="text-left">Net Amount</th>
                <th class="text-left">Action</th>
            </tr>
        </thead>
        <tbody>
            <tr class="hover" v-for="item in document" :key="item.log_id">
                <td>{{ item.dvNo }}</td>
                <td>{{ item.chequeNo }}</td>
                <td>{{ item.payeeName }}</td>
                <td>{{ item.accountCode }}</td>
                <td>{{ item.gross }}</td>
                <td>{{ (item.gross - item.D5 - item.DPhil - item.DPag - item.D3 - item.D2 - item.D1).toFixed(2) }}</td>
                <td class="d-flex ga-1" v-if="!item.archive">
                    <v-dialog max-width="80%">
                        <template v-slot:activator="{ props: activatorProps }">
                            <v-btn v-bind="activatorProps" rounded icon="mdi mdi-pencil" variant="plain"></v-btn>
                        </template>

                        <template v-slot:default="{ isActive }">
                            <v-card class="overflow-hidden">
                                <v-toolbar color="secondary">
                                    <v-toolbar-title>Edit Information</v-toolbar-title>
                                    <v-btn icon="mdi-close" @click="isActive.value = !isActive"></v-btn>
                                </v-toolbar>
                                <v-card-text>
                                    <Fill :selected="item" :getDataDb="getDataDb" :isActive="isActive" />
                                </v-card-text>
                            </v-card>
                        </template>
                    </v-dialog>
                    <v-dialog max-width="400">
                        <template v-slot:activator="{ props: activatorProps }">
                            <v-btn v-bind="activatorProps" rounded icon="mdi-archive-arrow-down-outline" variant="plain"></v-btn>
                        </template>

                        <template v-slot:default="{ isActive }">
                            <v-card>
                                <v-alert title="System Alert" text="The Data will move to archive section."
                                    type="warning" variant="outlined">
                                    <v-card-actions class="pa-0">
                                        <v-spacer></v-spacer>
                                        <v-btn variant="tonal" text="Cancel" @click="isActive.value = false"></v-btn>
                                        <v-btn text="Archive"
                                            @click="isArchive(item), isActive.value = false"></v-btn>
                                    </v-card-actions>
                                </v-alert>
                            </v-card>
                        </template>
                    </v-dialog>
                </td>
                <td v-else>
                    <v-dialog max-width="400">
                        <template v-slot:activator="{ props: activatorProps }">
                            <v-btn v-bind="activatorProps" rounded icon="mdi-archive-arrow-up-outline" variant="plain"></v-btn>
                        </template>

                        <template v-slot:default="{ isActive }">
                            <v-card>
                                <v-alert title="System Alert" text="Would you want to recover this data?"
                                    type="warning" variant="outlined">
                                    <v-card-actions class="pa-0">
                                        <v-spacer></v-spacer>
                                        <v-btn variant="tonal" text="Cancel" @click="isActive.value = false"></v-btn>
                                        <v-btn text="Recover"
                                            @click="isArchive(item), isActive.value = false"></v-btn>
                                    </v-card-actions>
                                </v-alert>
                            </v-card>
                        </template>
                    </v-dialog>
                    <v-dialog max-width="400">
                        <template v-slot:activator="{ props: activatorProps }">
                            <v-btn v-bind="activatorProps" rounded icon="mdi-delete-empty" variant="plain"></v-btn>
                        </template>

                        <template v-slot:default="{ isActive }">
                            <v-card>
                                <v-alert title="System Warning" text="Deletion of Data is Prohibited. Would you like to proceed?"
                                    type="error" variant="outlined">
                                    <v-card-actions class="pa-0">
                                        <v-spacer></v-spacer>
                                        <v-btn variant="tonal" text="Cancel" @click="isActive.value = false"></v-btn>
                                        <v-btn text="Delete" @click="del(item.log_id),  isActive.value = false"></v-btn>
                                    </v-card-actions>
                                </v-alert>
                            </v-card>
                        </template>
                    </v-dialog>
                </td>
            </tr>
        </tbody>
    </v-table>
</template>
<script>
import axios from 'axios';

export default {
    props: {
        document: {
            type: Array,
        },
        getDataDb: {
            type: Function,
        }
    },
    data() {
        return {
        }
    },
    methods: {
        isArchive(item){
            axios.post('http://localhost/StaCruzFRDBS_Php/crud.php', {
                action: 'archive',
                log_id: item.log_id,
                archive: !item.archive,
            }).then(response =>{
                console.log(response.data);
                this.getDataDb();
            })
        },
        del(id){
            axios.post('http://localhost/StaCruzFRDBS_Php/crud.php', {
                action: 'delete',
                log_id: id,
            }).then(response => {
                console.log(response.data);
                this.getDataDb();
            }).catch(error => {
                console.log(error);
            });
        }
    }
}
</script>
<style scope>
.hover:hover {
    box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2);
}
</style>