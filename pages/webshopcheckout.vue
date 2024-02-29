<template>
  <div class="back">
    <div class="indbetal">
      <div class="centering">
        <h2>Kontakt information</h2>
        <input type="email" name="email" id="email" placeholder="Email" />
        <div class="check">
          <Checkbox v-model="checked" :binary="true" class="check" />
          <p>Tilmeld mig opdateringer angående nye tilbud</p>
        </div>

        <h2>Shipping</h2>
        <select name="land" id="land">
          <option selected value="land">Land</option>
          <option value="danmark">Danmark</option>
          <option value="tyskland">Tyskland</option>
          <option value="sverige">Sverige</option>
          <option value="norge">Norge</option>
        </select>
        <div>
          <input type="text" name="fornavn" id="fnavn" placeholder="fornavn" />
          <input
            type="text"
            name="efternavn"
            id="enavn"
            placeholder="efternavn"
          />
        </div>
        <input type="text" name="adresse" id="adresse" placeholder="adresse" />
        <br />
        <input
          type="text"
          name="adressenummer"
          id="anummer"
          placeholder="adresse nr."
        />
        <div>
          <input
            type="number"
            name="postnummer"
            id="pnummer"
            placeholder="postnummer"
          />
          <input type="text" name="by" id="by" placeholder="by" />
        </div>
        <div class="check">
          <Checkbox v-model="checked" :binary="true" class="check" />
          <p>Gem mine kortinformationer</p>
        </div>
      </div>
    </div>
    <div class="kurv">
      <div class="produkt"></div>
      <div>
        <p>Subtotal</p>
        <p>Shipping</p>
        <p>Total</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import Checkbox from "primevue/checkbox";
import { ref } from "vue";

const checked = ref(false);
</script>

<style scoped>
.back {
  display: flex;
  flex-direction: row;
}
.indbetal {
  background-color: rgb(255, 255, 255);
  width: 50vw;
  padding-bottom: 50px;
}
.centering {
  width: 80%;
  margin: auto;
}
.kurv {
  width: 50vw;
  background-color: rgb(242, 242, 242);
  height: auto;
}
.check {
  display: flex;
  justify-content: flex-start;
  margin-left: 5px;
}
.check p {
  margin-left: 10px;
}
select,
h2 {
  margin-left: 10px;
  margin-bottom: 5px;
  margin-top: 5px;
}
input {
  border: solid;
  border-color: rgb(240, 240, 240);
  width: 45%;
  margin: 10px;
}
</style>
