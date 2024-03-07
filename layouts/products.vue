<template>
  <Header />
  <div class="main-bg height-calc">
    <!-- out the page content -->
    <div class="container mx-auto p-4">
      <slot />
    </div>
  </div>

  <footer>
    <div class="flex justify-center">
      <Footercard />
    </div>
  </footer>
</template>

<script setup>
import "primeicons/primeicons.css";

</script>
<style scoped>
@import url("~/assets/css/base.css");
.router-link-exact-active {
  color: #12b488;
}
</style>
