<template>
  <Header />
  <div class="main-bg max-h-full">
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

<style scoped>
.router-link-exact-active {
  color: #12b488;
}
.main-bg {
  background-color: #e8f7dd;
}
</style>
