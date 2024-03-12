<template>
    <div>

        <!-- Search function -->
        <div class="card flex flex-wrap justify-center gap-3" @click="visible = true">
            <IconField iconPosition="left">
                <InputIcon>
                    <i class="pi pi-search" />
                </InputIcon>
                <InputText placeholder="Søg efter produkter..." @click="visible = true" />
            </IconField>

        </div>
        <!-- Products -->
        <div class="produkt flex justify-center gap-3">
            <!-- <pre>
                {{ filter }}
            </pre> -->
            <Dialog v-model:visible="visible" modal header="Søg Efter Produkter" :style="{ width: '60rem', BorderRadius: '14px', background: '#e8f7dd', padding: '1rem', 'box-shadow': '0 0 10px 0 #000000'}"
                :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
                <div class="flex flex-wrap justify-center gap-3 searchbar_dialog">
                    <IconField iconPosition="left">
                        <InputIcon>
                            <i class="pi pi-search" />
                        </InputIcon>
                        <InputText v-model="searchQuery" placeholder="Alle Produkter" />
                    </IconField>
                </div>
                <article v-for="product in filter" :key="product.id" class="card dialog_produkt">
                    <div class="img_title" href="">
                        <div>
                            <img :src="product['product']['thumbnail']" alt="Product Image" width="50" />
                            <h2>{{ product["product"]["title"] }}</h2>
                        </div>
                        <div>
                            <h5>{{ product['product']['subtitle'] }}</h5>
                            <p>{{ product['product']['description'] }}</p>
                        </div>
                    </div>
                </article>
            </Dialog>

        </div>
    </div>
</template>

<script setup>
import { ref, computed, reactive } from 'vue';
import IconField from 'primevue/iconfield';
import InputIcon from 'primevue/inputicon';
import InputText from 'primevue/inputtext';

const visible = ref(false);
const searchQuery = ref('');
const { data: products, pending, error } = await useFetch('/api/products')

// Computed property to filter products
const filter = computed(() => {
    //console.log("Search query: ", searchQuery.value)
    //console.log("Products: ", products.value.products)
    if (products.value.products.length != 0) {
        let filteredProducts = []
        for (let i = 0; i < products.value.products.length; i++) {
            if (products.value.products[i]["title"].toLowerCase().includes(searchQuery.value.toLowerCase())) {
                filteredProducts.push({ product: { id: products.value.products[i]["id"], title: products.value.products[i]["title"], thumbnail: products.value.products[i]["thumbnail"], subtitle: products.value.products[i]["subtitle"], description: products.value.products[i]["description"], media: products.value.products[i]["media"] } })
            }
        }

        return filteredProducts
    }


});

</script>
<style>
    .produkt {
        margin-top: 2rem;
    }

    .dialog_produkt {
        display: flex;
        flex-direction: column;
        align-items: flex-start; /* Updated */
        justify-content: center;
        padding: 1rem;
        margin: 1rem;
        /* border: 1px solid #000; */
        border-radius: 5px;
    }

    .dialog_produkt img {
        width: 100px;
        height: 100px;
    }
    .searchbar_dialog {
        margin-top: 1rem;
        margin-bottom: 1rem;
    }
    .img_title img {
        width: 100px;
        height: 100px;
        border-radius: 12px;
    }
    .img_title h2 {
        margin-top: 1rem;
        font-size: x-large;
        font-weight: 500;
        padding: 10px;
    }
    .img_title h5 {
        font-size: large;
        font-weight: 500;
        padding-top: 10px;
    }


</style>
