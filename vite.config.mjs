export default {
  base: process.env.VITE_BASE_URL ?? "./",
  build: {
    target: "esnext",
  },
  server: {
    watch: {
      interval: 160,
      ignored: ["**/*.cirru"],
    },
  },
};
