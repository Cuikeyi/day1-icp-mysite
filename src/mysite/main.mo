import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Array "mo:base/Array";

actor {
    // 数组值交换
    func swap(array: [var Int], i: Nat, j: Nat) : () {
        let temp: Int = array[i];
        array[i] := array[j];
        array[j] := temp;
    };

    // 快排实现
    func qsortImp(array: [var Int], begin: Nat, end: Nat) : () {
        if (begin < end) {
            let key: Int = array[begin];
            var i: Nat = begin;
            var j: Nat = end;
            while (i < j) {
                while (i < j and array[j] > key) {
                    j-=1;
                };
                if (i < j) {
                    swap(array, i, j);
                    i+=1;
                };
                
                while (i < j and array[i] < key) {
                    i+=1;
                };
                if (i < j) {
                    swap(array, i, j);
                    j-=1;
                };
            };
            array[i] := key;
            if (i >= 1) {// 防止Nat类型溢出
                qsortImp(array, begin, i-1);    
            };
            qsortImp(array, i+1, end);
        };
    };

    // 快排可变数组函数
    func quicksort(array: [var Int]) : () {
        qsortImp(array, 0, array.size()-1);
    };

    // 快排对外暴露接口
    public func qsort(array: [Int]): async ([Int]) {
        if (array.size() <= 1) {
            return array;
        };
        let mutArray : [var Int] = Array.thaw(array);
        quicksort(mutArray);
        return Array.freeze(mutArray);
	};
};

// let array: [Int] = [0];
// Debug.print(debug_show(array));
// let result: [Int] = qsort(array);
// Debug.print(debug_show(result));
