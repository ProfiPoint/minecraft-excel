for (var i = 0; i < 10; i++) {

    function test() {
        function a(lol){
            console.log(lol);
        }
        test2(i, a); // Pass a as an argument to test2
    }

    function test2(i, callback) {
        // Call the function a with the value of i
        callback(i);
    }

    test(); // Call test within the closure
}
