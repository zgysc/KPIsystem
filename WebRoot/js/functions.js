function dualList(src, dest) {

    src = document.getElementById(src);
    dest = document.getElementById(dest);

    for (var j = 0; j < src.options.length; j++) {
        if (src.options[j].selected == true) {

            var text = src.options[j].text;
            var value = src.options[j].value;
            var newOption = new Option(text, value);
            try {
                dest.add(newOption, null);
            } catch(e) {
                dest.add(newOption, -1);
            }
            //var newOption = document.createElement("OPTION");
            //dest.options.add(newOption);
            // newOption.innerText = text;
            //newOption.value = value;
        }
    }
    //    for (var i = 0; i < dest.options.length; i++) {
    //        dest.options[i].selected = true;
    //    }

    //    for (var i = 0; i < dest.options.length; i++) {
    //        dest.options(i).selected = true;
    //    }

    for (var k = src.options.length - 1; k >= 0; k--) {
        if (src.options[k] != null && src.options[k].selected == true)
            src.options[k] = null;
    }
}

function checkValidation(value, message) {
    //var reg = /^([0-9a-zA-Z]+)$/;
    var reg = /^[_a-zA-Z0-9-]+$/;
//    reg = /^((0x)[0-9a-fA-F]{26})$/;

    //    alert("value is : " + value);
    if (reg.test(value)) {
        return true;
    } else {
        alert(message + " should be \"0-9\" or \"a-z\" or \"A-Z\" or \"-\" or \"_\".");
        return false;
    }
}

function parseFileName(filePath) {
    var fileName = filePath;
    var end = filePath.indexOf('\\');
    if (end != -1)
        fileName = filePath.split("\\")[filePath.split("\\").length - 1];
    var end2 = fileName.indexOf('/');
    if (end2 != -1)
        fileName = fileName.split("/")[fileName.split("/").length - 1];
    return fileName;
}


function checkFileName(value, message) {
    var reg = /^[_a-zA-Z0-9-\. ]+$/;
//    reg = /^((0x)[0-9a-fA-F]{26})$/;

    if (reg.test(value)) {
        return true;
    } else {
        alert(message + ' should be "0-9" or "a-z" or "A-Z" or "-" or "_" or " " or ".".');
        return false;
    }
}

function checkFilePath(value, message) {
    // parse file name
    value = parseFileName(value);
//    alert(value);
    return checkFileName(value, message);
}

function checkStrictFileName(value, message) {
    var reg = /^[_a-zA-Z0-9-\.]+$/;
//    reg = /^((0x)[0-9a-fA-F]{26})$/;

    if (reg.test(value)) {
        return true;
    } else {
        alert(message + ' should be "0-9" or "a-z" or "A-Z" or "-" or "_" or ".".');
        return false;
    }
}

function checkStrictFilePath(value, message) {
    value = parseFileName(value);
//    alert(value);

    return checkStrictFileName(value, message);
}

function checkEmail(value) {
    var emails = value.split(";");
    var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
    for (var i = 0; i < emails.length; i++) {
        if (!reg.test(emails[i])) {
            alert("\"" + emails[i] + "\" is invalid.");
            return false;
        }
    }
    return true;
}

function checkNum(value, message) {
    var reg1 = /^[0-9]$/;
//    alert("value is : " + value);
    //    alert(reg1.test(value));
    if (reg1.test(value)) {
        return true;
    } else {
        alert(message + " should be \"0-9\".");
        return false;
    }

}

function checkPort(value) {
    if (!/^\d+$/.test(value)) return false;
    if (value < 1 || value > 65535) return false;
    return true;
}

function alphanumeric(value) {
    return /^[a-zA-Z0-9]+$/.test(value);
}

function isHTTPURL(str_url) {
    return true;
    var strRegex = "^((https|http)://)"
            + "(([0-9a-zA-Z_!~*'().&=+$%-]+:)?[0-9a-zA-Z_!~*'().&=+$%-]+@)?" // ftp��user@
            + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP��ʽ��URL- 199.194.52.184
            + "|" // ����IP��DOMAIN������
            + "([0-9a-zA-Z_!~*'()-]+\.)*" // ����- www.
            + "([0-9a-zA-Z][0-9a-zA-Z]{0,61})?[0-9a-zA-Z]\." // ��������
            + "[a-zA-Z]{2,6})" // first level domain- .com or .museum
            + "(:[0-9]{1,4})?" // �˿�- :80
            + "((/?)|" // a slash isn't required if there is no file name
            + "(/[0-9a-zA-Z_!~*'().;?:@&=+$,%#-]+)+/?)$";
//    alert(strRegex);
    var re = new RegExp(strRegex);
 // re.test()
    if (re.test(str_url)) {
        return (true);
    } else {
        return (false);
    }
}