const colors = require("tailwindcss/colors");

module.exports = {
  purge: ["./app/**/*.html.erb", "./app/**/*.js.erb", "./app/helpers/**/*.rb"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        orange: colors.orange,
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
