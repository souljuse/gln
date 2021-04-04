const webpack = require("webpack");
const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  devtool: "source-map",
  mode: "development",
  entry: {
    application: ["./source/javascripts/index.js"],
    style: ["./source/stylesheets/application.sass"]
  },
  output: {
    path: path.resolve(__dirname, ".tmp/dist"),
    filename: "javascripts/[name].js"
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"]
          }
        }
      },
      {
        test: /\.(ttf|eot|svg|png|jpg|gif|ico|woff)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "file-loader"
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          MiniCssExtractPlugin.loader,
          "css-loader",
          "sass-loader",
          "import-glob-loader"
        ]
      }
    ]
  },
  plugins: [new MiniCssExtractPlugin()]
};
//
// module.exports = {
//   entry: {
//     application: __dirname + "/source/javascripts/index.js",
//     styles: __dirname + "/source/stylesheets/application.sass"
//   },
//   resolve: {
//     root: __dirname + "/source/javascripts"
//   },
//   output: {
//     path: __dirname + "/.tmp/dist",
//     filename: "javascripts/[name].js"
//   },
//   module: {
//     rules: [
//       {
//         test: /\.(sa|sc|c)ss$/,
//         loader: [
//           "style-loader",
//           "css-loader",
//           "sass-loader",
//           "import-glob-loader"
//         ],
//         exclude: /node_modules/
//       }
//     ]
//   },
//   plugins: [extractSass]
// };
