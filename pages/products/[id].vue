<template>
  <div>
    <!-- The way we are typing the Head on id is bcs now we can put product.title in the header so it matches the item -->
    <Head>
      <Title>Eco Fashion | {{ product.title }}</Title>
      <Meta name="description" :content="product.description" />
    </Head>
    <!-- Filteret content -->
    <ProductDetails :product="product" />
  </div>
</template>

<script setup>
// const { data: products, pending, error } = await useFetch('/api/products')
const { id } = useRoute().params; // We use useRoute to get the the name that its changing too ... like $_GET = "id" from php
const uri = "https://fakestoreapi.com/products/" + id; // know we know what id got send then we say link + id to get the right item

//fetch the products
const { data: product } = await useFetch(uri, { key: id }); // Get all the item content from uri and put it in a array to filter content out

if (!product.value) {
  throw createError({
    statusCode: 404,
    statusMessage: "Product not found",
    fatal: true,
  }); //If people are trying to get access threw the url and its a wrong product they will get an Error on 404 and a text about product not being found, fatal: true is there if they are getting a wrong id with a link the error will also be showed
}

definePageMeta({
  // Says we wanna use the product layout in Layout Folder
  layout: "products",
});
</script>

<style scoped></style>
