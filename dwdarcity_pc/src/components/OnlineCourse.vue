<template>
<div class="course">
  <Header></Header>
  <div class="main">
    <img src="../../static/image/construction.png" alt="">

  </div>
  <Footer></Footer>
</div>
</template>

<script>
import Header from "./common/Header";
import Footer from "./common/Footer";
export default {
  name: "OnlineCourse",
  components: {Footer, Header}
}
</script>

<style scoped>
.course {
  background: #f6f6f6;
}

.course .main {
  width: 1100px;
  margin: 35px auto 0;
}

</style>
