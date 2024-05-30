<template>
    <v-form @submit.prevent class="ma-10">
        <v-row>
            <v-col>
                <v-row>
                    <v-col>
                        <v-text-field v-model="document.dvNo" readonly label="DV Number"
                            :rules="[v => !!v || 'Required']" variant="outlined"></v-text-field>
                        <v-text-field v-model="document.chequeNo" clearable label="Cheque Number"
                            :rules="[v => !!v || 'Required']" variant="outlined"></v-text-field>
                        <v-text-field v-model="document.chequeDate" clearable label="Cheque Date Issued(YYYY-MM-DD)"
                            :rules="[v => !!v || 'Required']" variant="outlined"></v-text-field>
                        <v-text-field v-model="document.accountCode" clearable label="Account No"
                            :rules="[v => !!v || 'Required']" variant="outlined"></v-text-field>
                        <v-text-field v-model="document.payeeName" clearable label="Payee Name"
                            :rules="[v => !!v || 'Required']" variant="outlined"></v-text-field>
                        <v-text-field v-model="document.reason" clearable label="Reason/Purpose/Comment"
                            variant="outlined"></v-text-field>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col>
                        <v-btn @click="selectedDoc()" color="grey" width="100%" flat>Reset</v-btn>
                    </v-col>
                    <v-col>
                        <v-btn v-if="!selected" @click="submit(), isActive.value = !isActive" :text="submitText" flat
                            type="submit" color="secondary" width="100%"></v-btn>
                        <v-btn v-else @click="update(), isActive.value = !isActive" text="Update" flat type="submit"
                            color="secondary" width="100%"></v-btn>
                    </v-col>
                </v-row>
            </v-col>
            <v-col>
                <v-row no-gutters>
                    <v-col>
                        <v-text-field v-model="document.gross" label="Input the Total GROSS Amount" variant="outlined"
                            prefix="₱" :rules="[v => !!v || 'Required']"></v-text-field>
                        <div class="d-flex ga-3">
                            <v-checkbox v-model="checkPhil"></v-checkbox>
                            <v-text-field readonly v-model="deductionPhil" label="PhilHealth" variant="outlined"
                                prefix="₱"></v-text-field>
                            <v-checkbox label="PAG-IBIG" v-model="checkPag"></v-checkbox>
                            <v-text-field readonly v-model="deductionPag" label="Amount" variant="outlined"
                                prefix="₱"></v-text-field>
                        </div>
                        <div class="d-flex ga-3">
                            <v-checkbox label="5% Deduction" v-model="checkD5"></v-checkbox>
                            <v-text-field readonly v-model="deductionD5" label="Amount" variant="outlined"
                                prefix="₱"></v-text-field>
                        </div>
                        <div class="d-flex ga-3">
                            <v-checkbox label="3% Deduction" v-model="checkD3"></v-checkbox>
                            <v-text-field readonly v-model="deductionD3" label="Amount" variant="outlined"
                                prefix="₱"></v-text-field>
                        </div>
                        <div class="d-flex ga-3">
                            <v-checkbox label="2% Deduction" v-model="checkD2"></v-checkbox>
                            <v-text-field readonly v-model="deductionD2" label="Amount" variant="outlined"
                                prefix="₱"></v-text-field>
                        </div>
                        <div class="d-flex ga-3">
                            <v-checkbox label="1% Deduction" v-model="checkD1"></v-checkbox>
                            <v-text-field readonly v-model="deductionD1" label="Amount" variant="outlined"
                                prefix="₱"></v-text-field>
                        </div>
                        <v-text-field label="= Total NET Amount" variant="outlined" v-model="netTotal" readonly
                            prefix="₱"></v-text-field>
                    </v-col>
                </v-row>
            </v-col>
        </v-row>
    </v-form>
</template>
<script>
import axios from 'axios';

export default {
    props: {
        selected: {
            type: Object,
        },
        getDataDb: {
            type: Function,
        },
        isActive: {
            type: Object,
        }
    },
    data() {
        return {
            submitText: 'Submit',
            error: false,
            checkD5: false,
            checkD3: false,
            checkD2: false,
            checkD1: false,
            checkPhil: false,
            checkPag: false,
            document: {
                log_id: '',
                dvNo: '',
                chequeNo: '',
                chequeDate: '',
                accountCode: '',
                gross: null,
                D1: 0.00,
                D2: 0.00,
                D3: 0.00,
                D5: 0.00,
                DPhil: 0.00,
                DPag: 0.00,
                payeeName: '',
                reason: '',
                prepBy: '',
                prepDate: '',
                archive: '',
            },
        }
    },
    computed: {
        netTotal() {
            return (this.document.gross - this.document.D5 - this.document.DPhil - this.document.DPag - this.document.D3 - this.document.D2 - this.document.D1).toFixed(2);
        },
        deductionPhil() {
            return this.document.DPhil = this.checkPhil ? (this.document.gross * 0.05).toFixed(2) : '0.00';
        },
        deductionPag() {
            return this.document.DPag = this.checkPag ? (this.document.gross * 0.02).toFixed(2) : '0.00';
        },
        deductionD5() {
            return this.document.D5 = this.checkD5 ? (this.document.gross * 0.05).toFixed(2) : '0.00';
        },
        deductionD3() {
            return this.document.D3 = this.checkD3 ? (this.document.gross * 0.03).toFixed(2) : '0.00';
        },
        deductionD2() {
            return this.document.D2 = this.checkD2 ? (this.document.gross * 0.02).toFixed(2) : '0.00';
        },
        deductionD1() {
            return this.document.D1 = this.checkD1 ? (this.document.gross * 0.01).toFixed(2) : '0.00';
        },
    },
    methods: {
        selectedDoc() {
            if (this.selected) {
                this.document.log_id = this.selected.log_id;
                this.document.dvNo = this.selected.dvNo;
                this.document.chequeNo = this.selected.chequeNo;
                this.document.chequeDate = this.selected.chequeDate;
                this.document.accountCode = this.selected.accountCode;
                this.document.gross = this.selected.gross;
                this.document.D1 = this.selected.D1
                this.document.D2 = this.selected.D2
                this.document.D3 = this.selected.D3
                this.document.D5 = this.selected.D5
                this.document.DPhil = this.selected.DPhil
                this.document.DPag = this.selected.DPag
                this.document.payeeName = this.selected.payeeName;
                this.document.reason = this.selected.reason;
                this.document.prepBy = this.selected.prepBy;
                this.document.prepDate = this.selected.prepDate;

                this.checkD1 = this.selected.D1 > 0 ? true : false;
                this.checkD2 = this.selected.D2 > 0 ? true : false;
                this.checkD3 = this.selected.D3 > 0 ? true : false;
                this.checkD5 = this.selected.D5 > 0 ? true : false;
                this.checkPhil = this.selected.DPhil > 0 ? true : false;
                this.checkPag = this.selected.DPag > 0 ? true : false;
            } else {
                this.document.log_id = null;
                this.document.dvNo = null;
                this.document.chequeNo = null;
                this.document.chequeDate = null;
                this.document.accountCode = null;
                this.document.gross = null;
                this.document.D1 = null;
                this.document.D2 = null;
                this.document.D3 = null;
                this.document.D5 = null;
                this.document.DPhil = null;
                this.document.DPag = null;
                this.document.payeeName = null;
                this.document.reason = null;
                this.document.prepBy = null;
                this.document.prepDate = null;
                this.generateDvNo();
            }
        },
        submit() {
            axios.post('http://localhost/StaCruzFRDBS_Php/crud.php', {
                action: 'insert',
                log_id: this.document.log_id,
                dvNo: this.document.dvNo,
                chequeNo: this.document.chequeNo,
                chequeDate: this.document.chequeDate,
                accountCode: this.document.accountCode,
                gross: this.document.gross,
                D1: this.document.D1,
                D2: this.document.D2,
                D3: this.document.D3,
                D5: this.document.D5,
                DPhil: this.document.DPhil,
                DPag: this.document.DPag,
                payeeName: this.document.payeeName,
                reason: this.document.reason,
                prepBy: this.document.prepBy,
                prepDate: this.document.prepDate,
                archive: '0',
            }).then(response => {
                console.log(response.data);
                this.submitText = 'Submitted';
            })
        },
        update() {
            axios.post('http://localhost/StaCruzFRDBS_Php/crud.php', {
                action: 'update',
                log_id: this.document.log_id,
                dvNo: this.document.dvNo,
                chequeNo: this.document.chequeNo,
                chequeDate: this.document.chequeDate,
                accountCode: this.document.accountCode,
                gross: this.document.gross,
                D1: this.document.D1,
                D2: this.document.D2,
                D3: this.document.D3,
                D5: this.document.D5,
                DPhil: this.document.DPhil,
                DPag: this.document.DPag,
                payeeName: this.document.payeeName,
                reason: this.document.reason,
                prepBy: this.document.prepBy,
                prepDate: this.document.prepDate,
                archive: this.document.archive,
            }).then(response => {
                console.log(response.data);
                this.getDataDb();
            }).catch(error => {
                console.log(error);
            });
        },
        generateDvNo() {
            axios.post('http://localhost/StaCruzFRDBS_Php/crud.php', {
                action: 'generateDvNo',
            }).then((response) => {
                this.document.dvNo = response.data;
            })
        }
    },
    mounted() {
        this.selectedDoc();
    }
}
</script>