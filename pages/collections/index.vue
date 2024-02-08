<template>
  <h1 class="w-full text-center text-5xl font-bold pb-4">Collection</h1>
  <div class="grid grid-cols-4 gap-5">
    <NuxtLink to="/products?item" class="CCard"
      ><img src="" alt="" class="CImage" />
      <p class="CText">Products</p></NuxtLink
    >
    <NuxtLink to="/products?item=mand" class="CCard"
      ><img src="~/assets/img/menclothing.jpg" alt="" class="CImage" />
      <p class="CText">Men</p></NuxtLink
    >
    <NuxtLink to="/products?item=kvinde" class="CCard"
      ><img src="~/assets/img/womenclothing.jpg" alt="" class="CImage" />
      <p class="CText">Women</p></NuxtLink
    >
    <NuxtLink to="/products?item=jewelery" class="CCard"
      ><img src="~/assets/img/jewelery.jpg" alt="" class="CImage h-full" />
      <p class="CText">Jewelery</p></NuxtLink
    >
    <NuxtLink to="/products?item=electronics" class="CCard"
      ><img src="~/assets/img/electronics.jpg" alt="" class="CImage" />
      <p class="CText">Electronics</p></NuxtLink
    >
    <NuxtLink to="/products?item=new" class="CCard"
      ><img src="" alt="" class="CImage" />
      <p class="CText">New</p></NuxtLink
    >
    <NuxtLink to="/products" class="CCard"
      ><img src="" alt="" class="CImage" />
      <p class="CText">Empty</p></NuxtLink
    ><NuxtLink to="/products" class="CCard"
      ><img src="" alt="" class="CImage" />
      <p class="CText">Empty</p></NuxtLink
    >
  </div>
</template>

<script setup>
definePageMeta({
  layout: "products",
});
</script>
