<template>
  <div></div>

  <footer class="flex justify-center">
    <div class="my-auto">
      <div></div>
      <div class="flex">
        <input class="w-2/6" placeholder="Your Name" value="" />
        <input class="w-2/6" placeholder="Your Email Address" value="" />
        <input class="w-1/5 footersubmit" value="I WANT IT!" type="submit" />
      </div>
      <div class="mt-6 flex justify-center">
        <a href="#">
          <img class="mr-4" src="http://placehold.it/50x50?text=facebook" />
        </a>
        <a href="#">
          <img class="mr-4" src="http://placehold.it/50x50?text=instagram" />
        </a>
        <a href="#">
          <img class="mr-4" src="http://placehold.it/50x50?text=pinterest" />
        </a>
        <a href="#">
          <img class="" src="http://placehold.it/50x50?text=Youtube" />
        </a>
      </div>
      <div class="mt-9 mb-3 flex justify-center">
        <p>FAQ * Contact Us * Shipping & Returns</p>
      </div>
      <div class="flex sm:w-4/4 flex-wrap justify-center">
        <img class="" src="http://placehold.it/60x35?text=Amazon" />
        <img class="" src="http://placehold.it/60x35?text=AMEX" />
        <img class="" src="http://placehold.it/60x35?text=ApplePay" />
        <img class="" src="http://placehold.it/60x35?text=Discover" />
        <img class="" src="http://placehold.it/60x35?text=GooglePay" />
        <img class="" src="http://placehold.it/60x35?text=MasterCard" />
        <img class="" src="http://placehold.it/60x35?text=PayPal" />
        <img class="" src="http://placehold.it/60x35?text=Shop" />
        <img class="" src="http://placehold.it/60x35?text=V" />
        <img class="" src="http://placehold.it/60x35?text=Visa" />
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

footer input {
  color: #fdf5dc;
  padding: 1px;
  margin: 0rem 1rem 0rem 1rem;
  border-radius: 0.25rem;
  outline-width: 1px;
  outline-style: solid;
}

.footersubmit {
  border-radius: 9999px;
  background-color: black;
}

footer img {
  border-radius: 0.25rem;
  margin: 0.25rem;
  max-width: 100%;
  height: auto;
  vertical-align: middle;
}
</style>
