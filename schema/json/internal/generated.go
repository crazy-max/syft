// DO NOT EDIT: generated by schema/json/generate/main.go

package internal

import "github.com/anchore/syft/syft/pkg"

// ArtifactMetadataContainer is a struct that contains all the metadata types for a package, as represented in the pkg.Package.Metadata field.
type ArtifactMetadataContainer struct {
	AlpmMetadata               pkg.AlpmMetadata
	ApkMetadata                pkg.ApkMetadata
	BinaryMetadata             pkg.BinaryMetadata
	CargoPackageMetadata       pkg.CargoPackageMetadata
	CocoapodsMetadata          pkg.CocoapodsMetadata
	ConanLockMetadata          pkg.ConanLockMetadata
	ConanMetadata              pkg.ConanMetadata
	DartPubMetadata            pkg.DartPubMetadata
	DotnetDepsMetadata         pkg.DotnetDepsMetadata
	DpkgMetadata               pkg.DpkgMetadata
	GemMetadata                pkg.GemMetadata
	GolangBinMetadata          pkg.GolangBinMetadata
	GolangModMetadata          pkg.GolangModMetadata
	HackageMetadata            pkg.HackageMetadata
	JavaMetadata               pkg.JavaMetadata
	KbPackageMetadata          pkg.KbPackageMetadata
	LinuxKernelMetadata        pkg.LinuxKernelMetadata
	LinuxKernelModuleMetadata  pkg.LinuxKernelModuleMetadata
	MixLockMetadata            pkg.MixLockMetadata
	NixStoreMetadata           pkg.NixStoreMetadata
	NpmPackageJSONMetadata     pkg.NpmPackageJSONMetadata
	NpmPackageLockJSONMetadata pkg.NpmPackageLockJSONMetadata
	PhpComposerJSONMetadata    pkg.PhpComposerJSONMetadata
	PortageMetadata            pkg.PortageMetadata
	PythonPackageMetadata      pkg.PythonPackageMetadata
	PythonPipfileLockMetadata  pkg.PythonPipfileLockMetadata
	PythonRequirementsMetadata pkg.PythonRequirementsMetadata
	RDescriptionFileMetadata   pkg.RDescriptionFileMetadata
	RebarLockMetadata          pkg.RebarLockMetadata
	RpmMetadata                pkg.RpmMetadata
}
