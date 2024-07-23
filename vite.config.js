
export default {
  build: {
    target: 'esnext'
  },
  server: {
    watch: {
      interval: 160,
      ignored: ["**/*.cirru"],
    }
  }
};
