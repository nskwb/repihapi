module.exports = {
  purge: {
    enabled: true,
    content: ["app/views/**/*.html.erb", "app/javascript/**/*.css"],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
