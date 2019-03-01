echo "~~~~~~~~~~~~请选择项目类型(输入序号,CocoaPods项目请选2)~~~~~~~~~~~~~~~"
echo "  1 xcodeproj"
echo "  2 xcworkspace"
# 读取工程名称并存到变量里
read project
sleep 0.5
project="$project"

if [ -n "$project" ]
then
    if [ "$project" = "1" ]
    then
        projectType="xcodeproj"
        workspace="project"
    elif [ "$project" = "2" ]
    then
        projectType="xcworkspace"
        workspace="workspace"
    else
        echo "参数无效。。。。。"
        exit 1
    fi

    echo "~~~~~~~~~~~~请选择打包方式(输入序号)~~~~~~~~~~~~~~~"
    echo "  1 本地打包"
    echo "  2 远程打包"
    # 读取工程名称并存到变量里
    read packaging
    sleep 0.5
    packaging="$packaging"

    if [ -n "$packaging" ]
    then
        if [ "$packaging" = "2" -o "$packaging" = "1" ]
        then

            if [ "$packaging" = "2" ]
            then
                echo "~~~~~~~~~~~~请输入账户名称~~~~~~~~~~~~~~~"
                # 读取账户名称并存到变量里
                read userName
                sleep 0.5
                userName="$userName"
                # 判断用户是否有输入
                if [ -n "$userName" ]
                then
                    echo "~~~~~~~~~~~~请输入账户密码~~~~~~~~~~~~~~~"
                    # 读取账户名称并存到变量里
                    read password
                    sleep 0.5
                    password="$password"

                    # 判断用户是否有输入
                    if [ -n "$password" ]
                    then
                        #临时获取keychain的访问权限
                        security unlock-keychain -p $password /Users/$userName/Library/Keychains/Login.keychain
                    else
                        echo "参数无效。。。。。"
                        exit 1
                    fi
                else
                    echo "参数无效。。。。。"
                    exit 1
                fi
            fi

            echo "~~~~~~~~~~~~请输入工程名称~~~~~~~~~~~~~~~"
            # 读取工程名称并存到变量里
            read project_Name
            sleep 0.5
            project_Name="$project_Name"

            # 判读用户是否有输入
            if [ -n "$project_Name" ]
            then
                echo "~~~~~~~~~~~~请选择配置环境(输入序号)~~~~~~~~~~~~~~~"
                echo "  1 Release"
                echo "  2 Debug"

                # 读取用户输入并存到变量里
                read configuration
                sleep 0.5
                configuration="$configuration"

                # 判读用户是否有输入
                if [ -n "$configuration" ]
                then
                    echo "~~~~~~~~~~~~选择打包方式(输入序号)~~~~~~~~~~~~~~~"
                    echo "  1 app-store"
                    echo "  2 ad-hoc"
                    echo "  3 enterprise"
                    echo "  4 development"

                    # 读取用户输入并存到变量里
                    read parameter
                    sleep 0.5
                    parameter="$parameter"

                    # 判读用户是否有输入
                    if [ -n "$parameter" ]
                    then
                        #clean
                        xcodebuild clean -$workspace $project_Name.$projectType -scheme $project_Name -configuration $configuration
                        xcodebuild archive -$workspace $project_Name.$projectType -scheme $project_Name -archivePath ./$project_Name.xcarchive
                        if [ "$parameter" = "1" ]
                        then
                        xcodebuild -exportArchive -exportOptionsPlist app-store.plist -archivePath ./$project_Name.xcarchive -exportPath ./autoPackage -allowProvisioningUpdates
                        exit 0
                        elif [ "$parameter" = "2" ]
                        then
                        xcodebuild -exportArchive -exportOptionsPlist ad-hoc.plist -archivePath ./$project_Name.xcarchive -exportPath ./autoPackage -allowProvisioningUpdates
                        exit 0
                        elif [ "$parameter" = "3" ]
                        then
                        xcodebuild -exportArchive -exportOptionsPlist enterprise.plist -archivePath ./$project_Name.xcarchive -exportPath ./autoPackage -allowProvisioningUpdates
                        exit 0
                        elif [ "$parameter" = "4" ]
                        then
                        xcodebuild -exportArchive -exportOptionsPlist development.plist -archivePath ./$project_Name.xcarchive -exportPath ./autoPackage -allowProvisioningUpdates
                        exit 0
                        else
                            echo "参数无效。。。。。"
                            exit 1
                        fi
                    else
                        echo "参数无效。。。。。"
                        exit 1
                    fi
                else
                    echo "参数无效。。。。。"
                    exit 1
                fi
            else
                echo "参数无效。。。。。"
                exit 1
            fi

        else
            echo "参数无效。。。。。"
            exit 1
        fi
    else
        echo "参数无效。。。。。"
        exit 1
    fi

else
    echo "参数无效。。。。。"
    exit 1
fi






