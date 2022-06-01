<template>
  <div class="view">
    <Header></Header>
    <div class="study-home">
      <Main></Main>
    </div>
    <ul class="side"></ul>
    <div class="box"></div>
    <Footer></Footer>
  </div>


</template>

<script>
import Header from "./common/Header"
import Footer from "./common/Footer"
import Main from "./common/Main"


export default {
  name: "Study",
  data() {
    return {}
  },
  components: {
    Header,
    Footer,
    Main
  }
}
</script>

<style scoped>
.view {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.study-home {
  flex: 1;
  width: 100%;
  background: #fafafa;
}

.side {
  height: auto;
  position: fixed;
  left: 10px;
  bottom: 50%;
  margin-bottom: -108px;
  z-index: 10;
}

.side, .side li {
  width: 50px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
