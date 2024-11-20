<?php
use App\Http\Controllers\AchievementProductsController;
use App\Http\Controllers\AchievementStimuliController;
use App\Http\Controllers\AchievementsController;
use App\Http\Controllers\ProductsController;
use App\Http\Controllers\StimuliController;
use App\Http\Controllers\ParentsController;
 

use App\Http\Controllers\BlogsController;
use App\Http\Controllers\ChildrensController;
use App\Http\Controllers\DevelopmentCategoriesController;
use App\Http\Controllers\Front\HomeController as FrontHomeController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\KategoriBlogController;
use App\Http\Controllers\LogHistoriController;
use App\Http\Controllers\MenuGroupsController;
use App\Http\Controllers\MenuItemsController;
use App\Http\Controllers\PermissionsController;
use App\Http\Controllers\ProfilController;
use App\Http\Controllers\ResourceController;
use App\Http\Controllers\RolesController;
use App\Http\Controllers\RouteController;
use App\Http\Controllers\SlidersController;
use App\Http\Controllers\UsersController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::resource('/', FrontHomeController::class);

Auth::routes();

Route::get('/home', [HomeController::class, 'index'])->name('home');

Route::group(['middleware' => ['auth']], function () {
    Route::resource('sliders', SlidersController::class);
    Route::resource('achievement_products', AchievementProductsController::class);
    Route::resource('achievement_stimuli', AchievementStimuliController::class);
    Route::resource('achievements', AchievementsController::class);
    Route::resource('products', ProductsController::class);
    Route::resource('stimuli', StimuliController::class);
    Route::resource('development_categories', DevelopmentCategoriesController::class);
    Route::resource('children', ChildrensController::class);
    Route::resource('parents', ParentsController::class);


 

    Route::resource('routes', RouteController::class);
    Route::get('/generate-routes', [RouteController::class, 'generateRoutes'])->name('routes.generate');
    Route::resource('log_histori', LogHistoriController::class);
    Route::get('/log-histori/delete-all', [LogHistoriController::class, 'deleteAll'])->name('log-histori.delete-all');
    Route::resource('roles', RolesController::class);
    Route::resource('users', UsersController::class);
    Route::resource('permissions', PermissionsController::class);
    Route::resource('profil', ProfilController::class);
    Route::resource('menu_groups', MenuGroupsController::class);
    Route::resource('menu_items', MenuItemsController::class);
    Route::post('menu-items/update-positions', [MenuItemsController::class, 'updatePositions'])->name('menu_items.update_positions');
    Route::post('menu-groups/update-positions', [MenuGroupsController::class, 'updatePositions'])->name('menu_groups.update_positions');
    Route::get('/create-resource', [ResourceController::class, 'createForm'])->name('resource.create');
    Route::post('/create-resource', [ResourceController::class, 'createResource'])->name('resource.store');


    Route::resource('blogs', BlogsController::class);
    Route::resource('kategori_blog', KategoriBlogController::class);

});
