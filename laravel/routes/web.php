<?php

use App\Http\Controllers\HomeController;
use Illuminate\Support\Facades\Route;
Route::get("/", [HomeController::class,"index"])->name("home");
Route::view('/about', 'about')->name('about');

// Route::get('/', function () {
//     return view('welcome');
// });
// Route::get("{num1}/product/{num2}", function(int $num1=0, int $num2=0){
//     $result = $num1 + $num2;
//     return $result;
// })->whereNumber(['num1','num2']);

// //Route::get('/calculator', [CalculatorController::class ,'index']);
// Route::controller(CalculatorController::class)->group(function(){
//     Route::get('/sum/{num1}/{num2}', [CalculatorController::class,'sum']);
//     Route::get('/subtract/{num1}/{num2}', [CalculatorController::class,'subtract']);
// });

