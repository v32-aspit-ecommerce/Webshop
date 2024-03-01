<template>
  <Header />

  <div class="height-calc main-bg">
    <slot />
  </div>
  <sidebar-cart />

  <div class="flex justify-center">
    <Footercard />
  </div>
</template>

<script setup>
import "primeicons/primeicons.css";
</script>

<style scoped></style>
