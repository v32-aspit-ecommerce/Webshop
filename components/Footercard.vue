<template>
  <footer class="flex justify-center footer-between">
    <img class="flowers" src="~/assets/img/blomstleft.png" alt="" />
    <div class="flex justify-center">
      <div class="my-auto">
        <div class="flex"></div>
        <div class="flex">
          <input class="w-2/6" placeholder="Your Name" v alue="" />
          <input class="w-2/6" placeholder="Your Email Address" value="" />
          <input class="w-1/5 footersubmit" value="I WANT IT!" type="submit" />
        </div>
        <div class="mt-6 flex justify-center">
          <a href="#" class="mr-4">
            <i class="pi pi-twitter"></i>
          </a>
          <a href="#" class="mr-4">
            <i class="pi pi-youtube"></i>
          </a>
          <a href="#" class="mr-4">
            <i class="pi pi-reddit"></i>
          </a>
          <a href="#" class="mr-4">
            <i class="pi pi-facebook"></i>
          </a>
        </div>
        <div class="mt-3 mb-3 flex justify-center">
          <p class="text-2xl">FAQ * Contact Us * Shipping & Returns</p>
        </div>
        <div class="flex sm:w-4/4 flex-wrap justify-center">
          <a href="#" class="mr-4">
            <i class="pi pi-amazon"></i>
          </a>
          <a href="#" class="mr-4">
            <i class="pi pi-apple"></i>
          </a>
          <a href="#" class="mr-4">
            <i class="pi pi-paypal"></i>
          </a>
          <a href="#" class="mr-4">
            <i class="pi pi-credit-card"></i>
          </a>
          <a href="#" class="mr-4">
            <i class="pi pi-truck"></i>
          </a>
        </div>
      </div>
    </div>
    <img class="flowers" src="~/assets/img/blomstright.png" alt="" />
  </footer>
</template>

<script setup></script>

<style scoped>
footer {
  background-color: #1f464e;
  height: 375px;
  width: 100%;
}

/* Styles the flower pictures in the footer */
footer img{
  width: 20%;
}

/* Styles  the Submit button in the footer */
footer div div div input:last-of-type{
  border-radius: 9999px;
  background-color: #cf9ea9;
}

/* Styles the inputs in the footer */
footer input {
  color: #fdf5dc;
  padding: 1px;
  margin: 0rem 1rem 0rem 1rem;
  border-radius: 0.25rem;
  outline-width: 1px;
  outline-style: solid;
}


/* Styles the in the footer Icons */
footer i {
  font-size: 3rem;
  margin: 0.25rem;
  max-width: 100%;
  height: auto;
  vertical-align: middle;
}






/* this class styles the flower pictures in footer in the side */
.flowers {
  display: none;
}

@media screen and (min-width: 900px) {
  /* this class styles the flower pictures in footer in the side */
  .flowers {
    display: inline;
  }
  
  /* styles the footer so when the flowers are there they are at the side instead of the center */
  footer:first-of-type {
    justify-content:space-between;
  }
}
</style>
