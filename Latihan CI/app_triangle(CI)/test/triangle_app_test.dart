


import 'package:flutter_test/flutter_test.dart';

String detectTriangle(num sideA, num sideB, num sideC){
  /*if(sideA <1 || sideB < 1 || sideC < 1){
    throw Exception();
  }*/
  final sides = [sideA, sideB, sideC];
  sides.sort();

  sides.forEach((side) {
    if(side < 1){
      throw Exception();
    }
  });
  if(sides[0] + sides[1] <= sides[2]){
    throw Exception("Inequal Triangle");
  }
  if(sides[0] == sides[1] && sides[0] == sides[2]){
    return "Segitiga sama sisi";
  }
  if(sides[0] == sides[1] || sides[1] == sides[2]){
    return "Segitiga sama kaki";
  }
  /*if(sides[0] == sides[1] || sides[0] == sides[2] || sides[1] == sides[2]){
    return "Segitiga sama kaki";
  }*/


  return "Segitiga sembarang";

}

void main(){
  group('Detect the triangle', (){
    test('Should throw Error when there is side less than 1', (){
      expect(() => detectTriangle(-1, 2, 2), throwsA(isA<Exception>()));
      expect(() => detectTriangle(1, -2, 2), throwsA(isA<Exception>()));
      expect(() => detectTriangle(1, 2, -2), throwsA(isA<Exception>()));
    });

    test('should throw error when side a + b <= c', (){
      expect(() => detectTriangle(4, 1, 2), throwsA(isA<Exception>()));
      expect(() => detectTriangle(5, 1, 3), throwsA(isA<Exception>()));
    });

    test('should return "Segitiga sama sisi" when all sides are equal', (){
      expect(detectTriangle(1, 1, 1), "Segitiga sama sisi");
      expect(detectTriangle(2, 2, 1), isNot( "Segitiga sama sisi"));
    });

    test('should return "Segitiga sama kaki" when only two sides are equal', (){
      expect(detectTriangle(2, 2, 3), 'Segitiga sama kaki');
      expect(detectTriangle(4, 2, 4), 'Segitiga sama kaki');
      expect(detectTriangle(1, 2, 2), 'Segitiga sama kaki');
      expect(detectTriangle(4, 1, 4), 'Segitiga sama kaki');
    });

    test('should return "Segiti sembarang" when no sides are equal', (){
      expect(detectTriangle(2, 4, 3), "Segitiga sembarang");
    });
  });
}