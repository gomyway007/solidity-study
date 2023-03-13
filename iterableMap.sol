// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library InterableMap{
    struct Map{
        bytes32[] keys;
        mapping(bytes32 => uint256) values;
        mapping(bytes32 => uint256) indexOf;
        mapping(bytes32 => bool) exist;
    }

    function size(Map storage m) public view returns(uint256){
        return m.keys.length;
    }

    function set(Map storage m,bytes32 _key,uint256 _value) public {
        if(m.exist[_key]){//update
            m.values[_key] = _value;
        }else{//insert
            m.indexOf[_key] = m.keys.length;//放在push前面，否则需要 -1
            m.keys.push(_key);
            m.values[_key] = _value;
            m.exist[_key] = true;
        }
    }

    function get(Map storage m,bytes32 _key) public view returns(uint256) {
        return m.values[_key];
    }

    function getKeyByIndex(Map storage m,uint256 _index) public view returns(bytes32) {
        return m.keys[_index];
    }

    function del(Map storage m,bytes32 _key) public {
        if(!m.exist[_key]){
            return;
        }

        //注意删除顺序
        uint256 index = m.indexOf[_key];
        uint256 last = m.keys.length - 1;
        delete(m.values[_key]);
        delete(m.exist[_key]);
        delete(m.indexOf[_key]);

        m.indexOf[m.keys[last]] = index;
        m.keys[index] = m.keys[last];
        m.keys.pop();

    }
}


contract TestInterableMap{//不能继承library
    using InterableMap for InterableMap.Map;//using 后直接使用

    InterableMap.Map private im;

    function TestAll() public {
        assert(im.keys.length == 0);
        assert(im.values["aaa"] == 0);
        assert(im.indexOf["aaa"] == 0);
        assert(im.exist["aaa"] == false);

        im.set("aaa",111);
        assert(im.keys.length == 1);
        assert(im.get("aaa") == 111);
  
        assert(im.indexOf["aaa"] == 0);
        assert(im.exist["aaa"] == true);
        assert(im.getKeyByIndex(0) == "aaa");

        im.set("bbb",222);
        assert(im.keys.length == 2);
        assert(im.get("bbb") == 222);
        assert(im.indexOf["bbb"] == 1);
        assert(im.exist["bbb"] == true);
        assert(im.getKeyByIndex(1) == "bbb");

        im.set("bbb",2222);
        assert(im.keys.length == 2);
        assert(im.get("bbb") == 2222);
        assert(im.indexOf["bbb"] == 1);
        assert(im.exist["bbb"] == true);
        assert(im.getKeyByIndex(1) == "bbb");

        im.set("ccc",333);
        assert(im.keys.length == 3);
        assert(im.get("ccc") == 333);
        assert(im.indexOf["ccc"] == 2);
        assert(im.exist["ccc"] == true);
        assert(im.getKeyByIndex(2) == "ccc");       

        im.set("ddd",444);
        assert(im.keys.length == 4);
        assert(im.get("ddd") == 444);
        assert(im.indexOf["ddd"] == 3);
        assert(im.exist["ddd"] == true);
        assert(im.getKeyByIndex(3) == "ddd"); 

        im.del("ccc");
        assert(im.keys.length == 3);
        assert(im.get("ccc") == 0);
        assert(im.indexOf["ccc"] == 0);
        assert(im.exist["ccc"] == false);
        assert(im.getKeyByIndex(2) == "ddd");   

        im.del("ddd");
        assert(im.keys.length == 2);
        assert(im.get("ddd") == 0);
        //assert(im.indexOf["ddd"] == 0);
        assert(im.exist["ddd"] == false);
  
    }


}
