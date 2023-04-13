const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
    entry: {
        main: './ssm_web/src/main/webapp/pages/main.jsp',
        student_list: './ssm_web/src/main/webapp/pages/student_list.jsp',
        documentation: './ssm_web/src/main/webapp/pages/documentation.jsp',
        failer: './ssm_web/src/main/webapp/pages/failer.jsp',
        header: './ssm_web/src/main/webapp/pages/header.jsp',
        login: './ssm_web/src/main/webapp/pages/login.jsp',
        aside: './ssm_web/src/main/webapp/pages/aside.jsp',
        setGenerateTableParam: './ssm_web/src/main/webapp/pages/setGenerateTableParam.jsp',
        setTableViewParam: './ssm_web/src/main/webapp/pages/setTableViewParam.jsp',
        weekTable_hasStudents: './ssm_web/src/main/webapp/pages/weekTable_hasStudents.jsp',
        inputClassCourseInfo: './ssm_web/src/main/webapp/pages/InputPages/inputClassCourseInfo.jsp',
        inputVolunteerInfo: './ssm_web/src/main/webapp/pages/InputPages/inputVolunteerInfo.jsp',
        // 其他jsp文件的入口文件
    },
    output: {
        filename: '[name].js',
        path:  path.resolve(__dirname, 'ssm_web/src/main/webapp/pages/dist/'),
    },
    module: {
        rules: [
            {
                test: /\.jsp$/,
                use: 'raw-loader'
            },
            {
                test: /\.css$/i,
                use: [MiniCssExtractPlugin.loader, 'css-loader']
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env']
                    }
                }
            }
        ]
    },
    plugins: [
        new MiniCssExtractPlugin({
            filename: '[name].css'
        })
    ]
};