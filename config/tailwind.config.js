const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  darkMode: 'class',
  safelist: [
    'bg-blue-100',
    'text-blue-800',
    'border-blue-400',
    'bg-green-100',
    'text-green-800',
    'border-green-400',
    'bg-yellow-100',
    'text-yellow-800',
    'border-yellow-400',
    'bg-red-100',
    'text-red-800',
    'border-red-400',
    'bg-gray-100',
    'text-gray-800',
    'border-gray-400',
  ],
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
