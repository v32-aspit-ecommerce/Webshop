<template>
  <div></div>

  <footer class="flex justify-center">
    <div class="my-auto">
      hej hej
      <div>
        <input
          class="footertext border p-1 mr-4"
          placeholder="Your Name"
          value=""
        />
        <input
          class="footertext border p-1 mr-4"
          placeholder="Your Email Address"
          value=""
        />
        <input
          class="footertext submitcolor border p-1"
          value="I WANT IT!"
          type="submit"
        />
      </div>
    </div>
  </footer>
</template>

<script setup></script>

<style scoped>
footer {
  background-color: #1f464e;
  height: 350px;
}
.footertext {
  color: #fdf5dc;
}
.submitcolor {
  background-color: black;
}
</style>
